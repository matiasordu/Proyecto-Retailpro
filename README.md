# RetailPro 📊

Proyecto de análisis de datos para **RetailPro**, una empresa dedicada a la distribución de productos tecnológicos.

El proyecto busca organizar y analizar información de **ventas, clientes, productos, categorías y territorios** mediante SQL Server, con el objetivo de obtener información útil para la toma de decisiones comerciales.

## 🎯 Objetivo del proyecto

Transformar datos transaccionales en información útil para responder preguntas como:

- ¿Cuánto se vende y cómo evoluciona la facturación?
- ¿Qué productos generan mayores ingresos?
- ¿Qué clientes concentran el mayor gasto?
- ¿Qué productos o clientes no registran ventas?
- ¿Cómo se distribuyen las ventas por canal?

Los resultados pueden utilizarse posteriormente para construir análisis y dashboards en Power BI.

## 🗄️ Base de datos

El proyecto utiliza **SQL Server** y una base de datos denominada:

```text
Ventas_Tech_DB
```

### Tablas principales

| Tabla | Descripción |
|---|---|
| `ventas` | Registra las operaciones de venta |
| `clientes` | Contiene información de los clientes |
| `productos` | Contiene los productos comercializados |
| `categorias` | Clasifica los productos |
| `territorios` | Contiene información geográfica |

Las relaciones entre estas tablas permiten enriquecer las ventas con información de clientes, productos, categorías y territorios.

## 🛠️ Herramientas utilizadas

- **SQL Server:** creación y gestión de la base de datos.
- **SQL Server Management Studio (SSMS):** ejecución y validación de scripts.
- **GitHub:** almacenamiento y versionado del proyecto.
- **Power BI:** análisis y visualización de los datos.

## 📂 Estructura del repositorio

```text
Proyecto-Retailpro/
│
├── README.md
├── Ventas_Tech_DB.sql
├── m4_consultas_negocio.sql
├── m5_consultas_joins.sql
├── Pipeline_ETL_Orduña_Matías.pbix
└── Pre-entrega 8/
```

### Scripts SQL

**`Ventas_Tech_DB.sql`**
- Crea la base de datos.
- Crea las tablas.
- Define claves primarias y foráneas.
- Inserta datos de prueba.
- Permite validar la estructura.

**`m4_consultas_negocio.sql`**
Contiene consultas orientadas a responder preguntas de negocio mediante filtros, agregaciones y cálculos.

**`m5_consultas_joins.sql`**
Contiene consultas que combinan tablas mediante `JOIN` para enriquecer el análisis de ventas con información de clientes, productos y territorios.

## ▶️ Cómo ejecutar los scripts SQL

### Requisitos

- SQL Server instalado.
- SQL Server Management Studio (SSMS).
- Permisos para crear una base de datos.

### 1. Clonar el repositorio

```bash
git clone https://github.com/matiasordu/Proyecto-Retailpro.git
cd Proyecto-Retailpro
```

### 2. Crear la base de datos

Abrir **SQL Server Management Studio**, conectarse a la instancia de SQL Server y abrir:

```text
Ventas_Tech_DB.sql
```

Ejecutar el script completo.

El script verifica si la base de datos existe antes de crearla:

```sql
IF DB_ID('Ventas_Tech_DB') IS NULL
BEGIN
    CREATE DATABASE Ventas_Tech_DB;
END
```

Luego se selecciona la base:

```sql
USE Ventas_Tech_DB;
```

### 3. Verificar las tablas

Después de ejecutar el script deberían estar disponibles:

```text
categorias
territorios
clientes
productos
ventas
```

### 4. Ejecutar las consultas

Abrir `m4_consultas_negocio.sql` o `m5_consultas_joins.sql` y ejecutar las consultas sobre:

```sql
USE Ventas_Tech_DB;
```

## 📈 Análisis comercial

Las consultas permiten analizar, entre otros indicadores:

- Facturación.
- Cantidad de pedidos.
- Ticket promedio.
- Productos vendidos.
- Clientes con mayor gasto.
- Productos sin ventas.
- Clientes sin ventas.
- Ventas por canal.
- Información territorial.

Estos resultados sirven como base para el análisis comercial y la posterior visualización en Power BI.

## 🔍 Cambios y mejoras realizadas en esta versión del README

### 1. Se amplió la descripción del proyecto

La versión anterior se centraba principalmente en describir el script SQL. Se incorporó el **problema y objetivo de negocio de RetailPro** para explicar para qué se desarrolla el proyecto y qué decisiones busca apoyar.

### 2. Se incorporó una guía de ejecución

Se agregaron instrucciones paso a paso para **clonar el repositorio, crear la base de datos y ejecutar los scripts SQL**. Esto permite que otra persona pueda reproducir el proyecto sin depender de explicaciones externas.

### 3. Se documentó la estructura actual del repositorio

Se agregaron los archivos y entregables que forman parte del proyecto, incluyendo `m5_consultas_joins.sql` y el archivo de Power BI. Esto facilita la navegación y comprensión del repositorio.

### 4. Se vinculó la parte técnica con el análisis comercial

Se incorporó una sección específica sobre los análisis que pueden obtenerse a partir de las consultas SQL, conectando la implementación técnica con el objetivo de negocio.

## 🚀 Próximos pasos

- Incorporar nuevos KPIs comerciales.
- Profundizar el análisis temporal de ventas.
- Analizar la segmentación de clientes.
- Incorporar indicadores de rentabilidad.
- Optimizar consultas e índices según el volumen de datos.
- Continuar desarrollando el dashboard en Power BI.

## 👤 Autor

**Matías Orduña**

Proyecto académico de análisis de datos, SQL Server y Business Intelligence.

Repositorio:

https://github.com/matiasordu/Proyecto-Retailpro

## 📚 Estado del proyecto

🚧 **En desarrollo**

Proyecto realizado como aplicación práctica de SQL, análisis de datos y Business Intelligence.
