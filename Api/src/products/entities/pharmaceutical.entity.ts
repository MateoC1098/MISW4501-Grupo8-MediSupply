import { BaseProduct } from "./base-product.entity";

export interface Pharmaceutical extends BaseProduct {
  active_ingredient: string;
  dosage?: string;
  expiry_date?: Date;
}