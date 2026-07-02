# Retail Sales & Customer Insights Dashboard

I built this project to practice the full analyst workflow — going from a raw CSV all the way to a working dashboard, using SQL, Excel, and Power BI. I wanted something more real than a tutorial, so I used the Kaggle "Sample Superstore" dataset, which a lot of analysts use to practice on. It's about 10,000 orders from a US retail company between 2014 and 2017.

![Sales Overview](screenshots/screenshot-sales-overview.png)
![Customer & Segment Detail](screenshots/screenshot-customer-detail.png)

## What I did

I started in SQL since that felt like the most natural way to ask questions of the data directly — things like which region makes the most money, which products are actually profitable, and whether discounts are hurting margins more than they help sales. Once I had a feel for the numbers, I moved into Excel to build a proper dashboard with KPI cards and charts, and then rebuilt the same thing in Power BI so I could add filtering and make it interactive.

## What I found

A few things surprised me:

- **Tables and Bookcases are actually losing money.** Combined they've brought in over $320K in sales, but they're down more than $21K in profit. I wasn't expecting that going in — high sales usually gets treated as a good sign, but it's not the same thing as profit.
- **The West region brings in the most, but Central lags behind** even though it's not the smallest region by sales. Something worth digging into further if this were a real business (staffing, logistics costs, something else).
- **Heavy discounting really does eat into margin.** Orders discounted more than 20% have noticeably lower profit margins on average — sometimes negative. It's the kind of thing that's obvious once you see it in the data, but easy to miss if you're only looking at total sales.
- A small group of customers (Sean Miller, Tamara Chand, and a handful of others) account for a disproportionate share of revenue. Worth a mention if I were pitching a retention strategy.

## A problem I ran into

While building the Power BI version, I kept running into a strange bug where my visuals would randomly become invisible after I added a text box — turned out to be a rendering/z-order glitch, not an actual data issue. Closing and reopening the file fixed it. Small thing, but it ate up a chunk of time and taught me to save often and not panic when a chart disappears.

I also messed up a DAX measure early on by pasting multiple formulas into a single "New Measure" box instead of creating them one at a time — an easy mistake if you're new to Power BI.

## Tools used

- **SQL (SQLite)** — for the actual analysis queries
- **Excel** — pivot-style summaries, KPI cards, charts
- **Power BI** — the interactive version, with slicers for region, category, and date

## Files in this repo

- `retail_sales_data.csv` — the cleaned dataset
- `analysis_queries.sql` — the SQL queries behind the insights above
- `retail_sales.db` — same data as a SQLite database
- `Retail_Sales_Dashboard.xlsx` — the Excel version
- `Retail_Sales_Dashboard.pbix` — the Power BI version
- `screenshots/` — dashboard screenshots

## If you want to run this yourself

Open `retail_sales.db` in any SQLite browser and run the queries in `analysis_queries.sql`, or just open the Excel/Power BI files directly — they're both ready to explore.

---
Vishnu Narayanan G K · vishnunarayanangk@gmail.com · (https://www.linkedin.com/in/vishnu-narayanan-6ba849365)
