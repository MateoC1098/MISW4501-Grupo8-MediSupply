export interface BaseProduct {
  id: number;
  name: string;
  description?: string;
  type: 'pharmaceutical' | 'consumable';
  created_at: Date;
}

export interface ProductRegion {
  id: number;
  product_id: number;
  region_id: number;
  price: number;
  regulations?: string;
}