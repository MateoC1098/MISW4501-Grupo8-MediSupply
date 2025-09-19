import { BaseProduct } from "./base-product.entity";

export interface Consumable extends BaseProduct {
  brand?: string;
  unit?: string; // e.g., "500ml", "1kg"
}