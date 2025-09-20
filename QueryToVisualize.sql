SELECT tr.transaction_id as Transaction_ID, 
tr.branch_id as Branch_ID, 
tr.customer_name as Customer_Name, 
tr.date as Date, 
tr.discount_percentage as Discount_Percentage, 
tr.rating as Rating_Transaction, 
tr.product_id as Product_ID, 
pr.price as Price, 
pr.product_name as Product_Name, 
cb.branch_name as Branch_Name, 
cb.kota as Kota, 
cb.provinsi as Provinsi, 
cb.rating as Rating_Branch, 
pr.price - (pr.price*tr.discount_percentage) as Nett_Sales,
CASE
  WHEN pr.price <= 50000 THEN 0.1 
  WHEN pr.price BETWEEN 50000 AND 100000 THEN 0.15
  WHEN pr.price BETWEEN 100000 AND 300000 THEN 0.2
  WHEN pr.price BETWEEN 300000 AND 500000 THEN 0.25
  WHEN pr.price > 500000 THEN 0.30
END AS Gross_Profit_Percentage,
pr.price + (pr.price*CASE
  WHEN pr.price <= 50000 THEN 0.1 
  WHEN pr.price BETWEEN 50000 AND 100000 THEN 0.15
  WHEN pr.price BETWEEN 100000 AND 300000 THEN 0.2
  WHEN pr.price BETWEEN 300000 AND 500000 THEN 0.25
  WHEN pr.price > 500000 THEN 0.30 END) as Nett_Profit
FROM `rakamin-kf-analytics-472606.RakaminKFAnalytics.kf_final_transaction` AS tr 
JOIN `rakamin-kf-analytics-472606.RakaminKFAnalytics.kf_product` AS pr ON tr.product_id = pr.product_id 
JOIN `rakamin-kf-analytics-472606.RakaminKFAnalytics.kf_kantor_cabang` as cb ON tr.branch_id = cb.branch_id