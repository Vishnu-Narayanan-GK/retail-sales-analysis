# Notes on building the Power BI dashboard

Quick notes on how I built the Power BI version of this project, mostly so I remember what I did if I come back to it later. Might be useful if you're trying to do something similar.

## Getting the data in

Open Power BI Desktop, Home > Get Data > Text/CSV, pick the retail_sales_data.csv file. Click Transform Data before loading so you can check the column types in Power Query - I had to double check Order Date and Ship Date were actually typed as dates, and Sales/Profit/Quantity/Discount were numbers and not text.

## Measures

I created these as separate measures (Home or Modeling tab > New Measure). Note: create them one at a time - if you paste more than one formula into the same New Measure box it throws a syntax error, learned that one the hard way.

```
Total Sales = SUM(retail_sales_data[Sales])
Total Profit = SUM(retail_sales_data[Profit])
Total Orders = DISTINCTCOUNT(retail_sales_data[Order ID])
Profit Margin % = DIVIDE([Total Profit], [Total Sales])
Avg Order Value = DIVIDE([Total Sales], [Total Orders])
```

For a continuous month-by-month trend line (instead of the default Year/Quarter/Month hierarchy Power BI tries to auto-build), I added two extra columns instead:

```
YearMonth = FORMAT('retail_sales_data'[Order Date], "MMM YYYY")
YearMonthSort = YEAR('retail_sales_data'[Order Date]) * 100 + MONTH('retail_sales_data'[Order Date])
```

Then set YearMonth to sort by YearMonthSort (click YearMonth column > Column tools > Sort by column). Otherwise it sorts alphabetically which is useless for a date.

## Layout

Page 1 - Sales Overview:
- 4 KPI cards across the top: Total Sales, Total Profit, Total Orders, Profit Margin %
- Bar chart: Region on X-axis, Total Sales on Y-axis
- Line chart: YearMonth on X-axis, Total Sales on Y-axis
- Stacked bar chart: Sub-Category on Y-axis, Total Sales on X-axis, Category as Legend

Page 2 - Customer & Segment Detail:
- Table: Customer Name + Total Sales, sorted descending, filtered to Top 10
- Donut chart: Segment as Legend, Total Sales as Values

I split it into two pages mostly because I ran out of room trying to fit everything on one - honestly works better this way anyway, keeps each page focused.

## Things that went wrong

Ran into a weird bug where charts would go invisible after I added a text box - some kind of rendering/layering glitch. Closing and reopening the file fixed it. If that happens to you, don't panic and don't assume your data's broken, it's probably just a redraw issue.

Also the Profit Margin % card defaulted to showing as a plain decimal (0.12 instead of 12%) - fixed by selecting the measure itself in the Data pane (not the visual) and changing the format to Percentage under the Modeling tab.

## Exporting

File > Export > Export to PDF gets you both pages as one file. Or just screenshot each page separately (Win+Shift+S) if you want individual images for a README.
