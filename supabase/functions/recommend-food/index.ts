import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

type Product = {
  id: string | number;
  category_id: string | number | null;
  name: string;
  description: string | null;
  price: number;
  estimated_time: number | null;
  image_url: string | null;
};

type OrderProduct = {
  product_id: string | number;
  quantity: number | null;
  products: {
    id: string | number;
    name: string;
    category_id: string | number | null;
  } | null;
};

type Order = {
  id: string | number;
  total_price: number | null;
  status: string | null;
  order_products: OrderProduct[] | null;
};

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

function jsonResponse(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      ...corsHeaders,
      "Content-Type": "application/json",
    },
  });
}

function asId(value: unknown) {
  return String(value ?? "");
}

function parseExclude(value: unknown) {
  if (!Array.isArray(value)) return new Set<string>();
  return new Set(value.map(asId).filter((id) => id.length > 0));
}

function extractJsonObject(text: string) {
  const cleaned = text.replace(/```json/gi, "").replace(/```/g, "").trim();
  const start = cleaned.indexOf("{");
  const end = cleaned.lastIndexOf("}");

  if (start === -1 || end === -1 || end < start) {
    throw new SyntaxError("Gemini returned invalid JSON.");
  }

  return JSON.parse(cleaned.slice(start, end + 1));
}

function chooseLocalProduct(
  products: Product[],
  averageBudget: number,
  favoriteCategoryId: string | null,
) {
  return [...products].sort((a, b) => {
    const aFavorite = favoriteCategoryId !== null &&
        asId(a.category_id) === favoriteCategoryId
      ? 0
      : 1;
    const bFavorite = favoriteCategoryId !== null &&
        asId(b.category_id) === favoriteCategoryId
      ? 0
      : 1;

    if (aFavorite !== bFavorite) return aFavorite - bFavorite;

    if (averageBudget > 0) {
      return Math.abs(Number(a.price) - averageBudget) -
        Math.abs(Number(b.price) - averageBudget);
    }

    return Number(a.price) - Number(b.price);
  })[0];
}

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  if (req.method !== "POST") {
    return jsonResponse({ error: "Method not allowed." }, 405);
  }

  const authHeader = req.headers.get("Authorization");
  if (!authHeader) {
    return jsonResponse({ error: "Missing authorization header." }, 401);
  }

  let body: Record<string, unknown> = {};
  try {
    body = await req.json();
  } catch (_) {
    body = {};
  }

  const excludedProducts = parseExclude(body.exclude);

  const supabaseUrl = Deno.env.get("SUPABASE_URL");
  const supabaseAnonKey = Deno.env.get("SUPABASE_ANON_KEY");
  const geminiApiKey = Deno.env.get("GEMINI_API_KEY");

  if (!supabaseUrl || !supabaseAnonKey) {
    return jsonResponse({ error: "Supabase environment is not configured." }, 500);
  }

  const supabase = createClient(supabaseUrl, supabaseAnonKey, {
    global: {
      headers: { Authorization: authHeader },
    },
  });

  const {
    data: { user },
    error: authError,
  } = await supabase.auth.getUser();

  if (authError || !user) {
    return jsonResponse({ error: "Unauthorized." }, 401);
  }

  const { data: productsData, error: productsError } = await supabase
    .from("products")
    .select(`
      id,
      category_id,
      name,
      description,
      price,
      estimated_time,
      image_url
    `);

  if (productsError) {
    return jsonResponse({ error: productsError.message }, 500);
  }

  const products = (productsData ?? []) as Product[];
  const availableProducts = products.filter((p) => !excludedProducts.has(asId(p.id)));

  if (availableProducts.length === 0) {
    return jsonResponse({ error: "No products are available to recommend." }, 404);
  }

  const { data: ordersData, error: ordersError } = await supabase
    .from("orders")
    .select(`
      id,
      customer_id,
      total_price,
      status,
      order_products (
        order_id,
        product_id,
        quantity,
        products (
          id,
          name,
          category_id
        )
      )
    `)
    .eq("customer_id", user.id)
    .order("id", { ascending: false });

  if (ordersError) {
    return jsonResponse({ error: ordersError.message }, 500);
  }

  const orders = (ordersData ?? []) as Order[];
  const averageBudget = orders.length === 0
    ? 0
    : orders.reduce((sum, order) => sum + Number(order.total_price ?? 0), 0) /
      orders.length;

  const categoryCounts = new Map<string, number>();
  const previousOrders = orders.map((order) => ({
    id: order.id,
    total_price: Number(order.total_price ?? 0),
    status: order.status,
    products: (order.order_products ?? [])
      .filter((item) => item.products)
      .map((item) => ({
        id: item.products!.id,
        name: item.products!.name,
        category_id: item.products!.category_id,
        quantity: Number(item.quantity ?? 1),
      })),
  }));

  for (const order of orders) {
    for (const item of order.order_products ?? []) {
      if (!item.products?.category_id) continue;
      const categoryId = asId(item.products.category_id);
      const quantity = Math.max(Number(item.quantity ?? 1), 1);
      categoryCounts.set(categoryId, (categoryCounts.get(categoryId) ?? 0) + quantity);
    }
  }

  let favoriteCategoryId: string | null = null;
  let favoriteCategoryCount = 0;
  for (const [categoryId, count] of categoryCounts.entries()) {
    if (count > favoriteCategoryCount) {
      favoriteCategoryId = categoryId;
      favoriteCategoryCount = count;
    }
  }

  const lastOrderedProductId = previousOrders[0]?.products[0]?.id == null
    ? null
    : asId(previousOrders[0].products[0].id);

  let candidates = availableProducts.filter((p) => asId(p.id) !== lastOrderedProductId);
  if (favoriteCategoryId !== null) {
    const favoriteCandidates = candidates.filter(
      (p) => asId(p.category_id) === favoriteCategoryId,
    );
    if (favoriteCandidates.length > 0) candidates = favoriteCandidates;
  }

  if (candidates.length === 0) {
    candidates = availableProducts;
  }

  candidates = [...candidates].sort((a, b) => {
    if (averageBudget > 0) {
      return Math.abs(Number(a.price) - averageBudget) -
        Math.abs(Number(b.price) - averageBudget);
    }

    return Number(a.price) - Number(b.price);
  }).slice(0, 20);

  if (candidates.length === 0) {
    return jsonResponse({ error: "No candidate products are available." }, 404);
  }

  const prompt = `
You recommend food for a restaurant ordering app.

Choose exactly one product from candidate_products. Never invent products.
Prefer the favorite category, avoid the last ordered product when possible, and stay near the average budget.
If there is no order history, choose a beginner-friendly product.

Return only JSON with this shape:
{"product_id":"", "reason":""}

favorite_category_id: ${favoriteCategoryId ?? "none"}
average_budget: ${averageBudget}
last_ordered_product_id: ${lastOrderedProductId ?? "none"}
previous_orders: ${JSON.stringify(previousOrders)}
candidate_products: ${JSON.stringify(candidates)}
`;

  let geminiJson: { product_id?: unknown; reason?: unknown } = {};

  try {
    if (!geminiApiKey) {
      throw new Error("Gemini API key is not configured.");
    }

    const geminiResponse = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${geminiApiKey}`,
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          contents: [{ parts: [{ text: prompt }] }],
          generationConfig: {
            temperature: 0.4,
            topP: 0.9,
            maxOutputTokens: 250,
            responseMimeType: "application/json",
          },
        }),
      },
    );

    if (!geminiResponse.ok) {
      const details = await geminiResponse.text();
      throw new Error(`Gemini request failed: ${details}`);
    }

    const gemini = await geminiResponse.json();
    if (gemini.error) {
      throw new Error(gemini.error.message ?? "Gemini returned an error.");
    }

    const rawText = gemini.candidates?.[0]?.content?.parts
      ?.map((part: { text?: string }) => part.text ?? "")
      .join("")
      .trim();

    if (!rawText) {
      throw new Error("Gemini returned no recommendation.");
    }

    geminiJson = extractJsonObject(rawText);
  } catch (error) {
    console.error("Gemini unavailable, using local recommendation.", error);
  }

  const geminiProduct = candidates.find(
    (product) => asId(product.id) === asId(geminiJson.product_id),
  );
  const selectedProduct =
    geminiProduct ?? chooseLocalProduct(candidates, averageBudget, favoriteCategoryId);

  if (!selectedProduct) {
    return jsonResponse({ error: "No product could be selected." }, 404);
  }

  const reason = geminiProduct &&
      typeof geminiJson.reason === "string" &&
      geminiJson.reason.trim()
    ? geminiJson.reason.trim()
    : orders.length === 0
    ? "A friendly first pick with an easy price and broad appeal."
    : "This matches your recent taste and stays close to your usual budget.";

  return jsonResponse({
    product: selectedProduct,
    reason,
  });
});
