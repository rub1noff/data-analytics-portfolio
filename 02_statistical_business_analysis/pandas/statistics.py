import pandas as pd

orders = pd.read_csv("data/orders.csv")
completed_orders = orders[orders["status"] == "completed"]

mean_amount = completed_orders["amount"].mean()
median_amount = completed_orders["amount"].median()
std_amount = completed_orders["amount"].std()

print("Среднее:", round(mean_amount, 2))
print("Медиана:", round(median_amount, 2))
print("Стандартное отклонение:", round(std_amount, 2))
