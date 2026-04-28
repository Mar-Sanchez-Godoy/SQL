## 📘 SQL Scripts Overview (Power BI-Oriented)

This repository contains three independent SQL exercises designed to practice data modeling, relational structures, and analytical queries.  
Each dataset can be easily imported into **Power BI** to build dashboards, KPIs, and dimensional models.

Below is a summary of each SQL file and its potential application in Power BI.

---

### 1) **Storage Capacity & Consumption Model (Valdoria Project)**  
**File:** `capacidad_almacenamiento.sql` + `consumo_grupos.sql`

This script simulates a small **data warehouse scenario**, including:

- A **fact table** for daily food consumption  
- A **dimension table** for population groups  
- A **capacity table** for storage infrastructure  

**Power BI applications:**

- Build a **star schema** (Dim_Grupo → Fact_Consumo)  
- Create KPIs such as:
  - Total storage capacity  
  - Daily consumption per group  
  - Days of autonomy  
- Visualize consumption vs. capacity using:
  - Donut charts  
  - Bar charts  
  - KPI cards  

This dataset is ideal for practicing **dimensional modeling** and **DAX calculations**.

---

### 2) **Restaurant Menu Dataset**  
**File:** `menu_restaurante.sql`

This script creates a simple table with:

- Menu items  
- Prices  
- Categories  
- Aggregations and averages  

**Power BI applications:**

- Build a **menu cost dashboard**  
- Analyze:
  - Average price per category  
  - Most expensive items  
  - Category distribution  
- Practice:
  - Data cleaning  
  - Column transformations  
  - Basic measures  

Perfect for beginners learning **ETL + visualization**.

---

### 3) **Employee Dataset (HR + Sales)**  
**File:** `empleados.sql`

This script defines an employee table with:

- Roles  
- Salaries  
- Branches  
- Countries  
- Sales performance  
- Hire dates  

**Power BI applications:**

- HR dashboards:
  - Salary distribution  
  - Employees by role or country  
  - Seniority analysis  
- Sales dashboards:
  - Total sales  
  - Sales by employee  
  - Sales by branch  

Great for practicing **date intelligence**, **filters**, and **hierarchies**.

---

## 🎯 Purpose of This Repository

These SQL exercises are designed to:

- Practice relational modeling  
- Prepare datasets for Power BI  
- Build dashboards from scratch  
- Strengthen SQL fundamentals  
- Simulate real-world BI scenarios  

Each script is intentionally simple, clean, and ready to load into Power BI.




#Castellano

## 📘 Descripción de los Scripts SQL (Enfocados en Power BI)

Este repositorio contiene tres ejercicios SQL independientes diseñados para practicar modelado de datos, estructuras relacionales y consultas analíticas.  
Cada dataset puede importarse fácilmente en **Power BI** para crear dashboards, KPIs y modelos dimensionales.

A continuación se explica el propósito de cada script y cómo puede utilizarse dentro de Power BI.

---

### 1) **Modelo de Capacidad y Consumo (Proyecto Valdoria)**  
**Archivos:** `capacidad_almacenamiento.sql` y `consumo_grupos.sql`

Este script simula un pequeño escenario de **data warehouse**, incluyendo:

- Una **tabla de hechos** para el consumo diario de alimentos  
- Una **tabla dimensión** para los grupos de población  
- Una tabla de **capacidad de almacenamiento**  

**Aplicaciones en Power BI:**

- Construir un **modelo en estrella** (Dim_Grupo → Fact_Consumo)  
- Crear KPIs como:
  - Capacidad total de almacenamiento  
  - Consumo diario por grupo  
  - Días de autonomía  
- Visualizaciones recomendadas:
  - Gráficos de barras  
  - Donuts de distribución  
  - Tarjetas KPI  

Este dataset es ideal para practicar **modelado dimensional** y **cálculos DAX**.

---

### 2) **Dataset de Menú de Restaurante**  
**Archivo:** `menu_restaurante.sql`

Este script crea una tabla sencilla con:

- Platos  
- Precios  
- Categorías  
- Consultas de agregación y promedios  

**Aplicaciones en Power BI:**

- Construir un dashboard de **análisis de precios**  
- Visualizar:
  - Precio promedio por categoría  
  - Platos más caros  
  - Distribución del menú  
- Practicar:
  - Transformaciones de columnas  
  - Limpieza de datos  
  - Medidas básicas  

Perfecto para aprender **ETL + visualización** de forma simple.

---

### 3) **Dataset de Empleados (RRHH + Ventas)**  
**Archivo:** `empleados.sql`

Este script define una tabla con:

- Puestos  
- Salarios  
- Sucursales  
- Países  
- Ventas por empleado  
- Fecha de ingreso  

**Aplicaciones en Power BI:**

- Dashboards de Recursos Humanos:
  - Distribución salarial  
  - Empleados por rol o país  
  - Antigüedad  
- Dashboards de ventas:
  - Ventas totales  
  - Ventas por empleado  
  - Ventas por sucursal  

Ideal para practicar **inteligencia de fechas**, **filtros**, **segmentaciones** y **jerarquías**.

---

## 🎯 Objetivo del Repositorio

Estos ejercicios SQL están diseñados para:

- Practicar fundamentos de SQL  
- Preparar datasets para Power BI  
- Construir dashboards desde cero  
- Simular escenarios reales de Business Intelligence  
- Reforzar modelado relacional  

Cada script es simple, limpio y listo para cargar en Power BI.

