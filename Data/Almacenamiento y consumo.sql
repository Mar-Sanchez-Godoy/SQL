CREATE TABLE Capacidad_Almacenamiento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_instalacion VARCHAR(50) NOT NULL,
    cantidad INT,
    capacidad_toneladas_unidad INT,
    capacidad_total_toneladas INT
);

INSERT INTO Capacidad_Almacenamiento 
(tipo_instalacion, cantidad, capacidad_toneladas_unidad, capacidad_total_toneladas)
VALUES
('graneros', 6, 40, 240),
('camaras_frias', 2, 30, 60),
('banco_semillas', 1, 5, 5),
('reserva_estrategica', 1, 30, 30);

SELECT SUM(capacidad_total_toneladas) AS total_capacidad
FROM Capacidad_Almacenamiento;

CREATE TABLE Dim_Grupo (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_grupo VARCHAR(50) NOT NULL
);

INSERT INTO Dim_Grupo (nombre_grupo) VALUES
('trabajadores'),
('ninos'),
('estudiantes'),
('ancianos'),
('guardias'),
('administracion');

CREATE TABLE Fact_Consumo (
    id_consumo INT AUTO_INCREMENT PRIMARY KEY,
    id_grupo INT NOT NULL,
    personas INT,
    consumo_kg_dia_persona DECIMAL(5,2),
    consumo_total_kg_dia DECIMAL(10,2),
    FOREIGN KEY (id_grupo) REFERENCES Dim_Grupo(id_grupo)
);

INSERT INTO Fact_Consumo 
(id_grupo, personas, consumo_kg_dia_persona, consumo_total_kg_dia)
VALUES
(1, 1100, 1.1, 1210),
(2, 300, 0.7, 210),
(3, 250, 0.9, 225),
(4, 200, 0.8, 160),
(5, 120, 1.2, 144),
(6, 130, 1.0, 130);

CREATE TABLE Dim_TipoInstalacion (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL
);

INSERT INTO Dim_TipoInstalacion (nombre_tipo) VALUES
('graneros'),
('camaras_frias'),
('banco_semillas'),
('reserva_estrategica');


CREATE TABLE Fact_Almacenamiento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_tipo INT NOT NULL,
    cantidad INT,
    capacidad_toneladas_unidad INT,
    capacidad_total_toneladas INT,
    FOREIGN KEY (id_tipo) REFERENCES Dim_TipoInstalacion(id_tipo)
);

INSERT INTO Fact_Almacenamiento
(id_tipo, cantidad, capacidad_toneladas_unidad, capacidad_total_toneladas)
VALUES
(1, 6, 40, 240),
(2, 2, 30, 60),
(3, 1, 5, 5),
(4, 1, 30, 30);


SELECT 
    d.nombre_tipo AS tipo_instalacion,
    f.cantidad,
    f.capacidad_toneladas_unidad,
    f.capacidad_total_toneladas
FROM Fact_Almacenamiento f
JOIN Dim_TipoInstalacion d
    ON f.id_tipo = d.id_tipo;

    SELECT 
    SUM(consumo_total_kg_dia) AS consumo_total_diario_kg
FROM Fact_Consumo;

SELECT 
    d.nombre_tipo AS tipo_instalacion,
    f.capacidad_total_toneladas,
    (f.capacidad_total_toneladas * 1000) / (
        SELECT SUM(consumo_total_kg_dia) FROM Fact_Consumo
    ) AS dias_autonomia
FROM Fact_Almacenamiento f
JOIN Dim_TipoInstalacion d
    ON f.id_tipo = d.id_tipo;

SELECT 
    SUM(consumo_total_kg_dia) / SUM(personas) AS consumo_promedio_por_persona
FROM Fact_Consumo;

SELECT 
    d.nombre_tipo AS tipo_instalacion,
    f.capacidad_total_toneladas * 1000 AS capacidad_kg,
    (f.capacidad_total_toneladas * 1000) / (
        SELECT SUM(consumo_total_kg_dia) / SUM(personas) FROM Fact_Consumo
    ) AS personas_que_puede_alimentar
FROM Fact_Almacenamiento f
JOIN Dim_TipoInstalacion d
    ON f.id_tipo = d.id_tipo;

SELECT 
    SUM(capacidad_total_toneladas) * 1000 /
    (SELECT SUM(consumo_total_kg_dia) FROM Fact_Consumo)
    AS dias_autonomia_total
FROM Fact_Almacenamiento;


/* 
1) Consulta: Capacidad total por tipo de instalación

Objetivo:
Obtener la capacidad total de almacenamiento por tipo de instalación.

Notas:
- Se usa Dim_TipoInstalacion para obtener el nombre descriptivo.
- Fact_Almacenamiento contiene las métricas (hecho).
- Relación 1:N entre Dim_TipoInstalacion → Fact_Almacenamiento.
*/

SELECT 
    d.nombre_tipo AS tipo_instalacion,     -- Nombre descriptivo de la instalación
    f.cantidad,                            -- Número de unidades de ese tipo
    f.capacidad_toneladas_unidad,          -- Capacidad por unidad (toneladas)
    f.capacidad_total_toneladas            -- Capacidad total (toneladas)
FROM Fact_Almacenamiento f
JOIN Dim_TipoInstalacion d 
    ON f.id_tipo = d.id_tipo;              -- Clave foránea que conecta ambas tablas


/* 
2) Consulta: Consumo total diario de toda Valdoria

Objetivo:
Calcular el consumo total diario de alimentos en Valdoria.

Notas:
- Fact_Consumo contiene métricas por grupo poblacional.
- SUM(consumo_total_kg_dia) agrega el consumo de todos los grupos.
*/

SELECT 
    SUM(consumo_total_kg_dia) AS consumo_total_diario_kg  -- Total en kg/día
FROM Fact_Consumo;

/* 
3) Consulta: Días de autonomía por tipo de instalación

Objetivo:
Calcular cuántos días puede alimentar cada tipo de instalación a toda la población.

Fórmula:
dias_autonomia = (capacidad_total_toneladas * 1000) / consumo_total_diario_kg

Notas:
- Se convierte toneladas → kg multiplicando por 1000.
- Se usa una subconsulta para obtener el consumo total diario.
*/

SELECT 
    d.nombre_tipo AS tipo_instalacion,          -- Tipo de instalación
    f.capacidad_total_toneladas,                -- Capacidad total (toneladas)
    
    /* 
    Cálculo de días de autonomía:
    capacidad_total_kg / consumo_total_diario_kg
    */
    (f.capacidad_total_toneladas * 1000) /
    (SELECT SUM(consumo_total_kg_dia) FROM Fact_Consumo) 
        AS dias_autonomia
FROM Fact_Almacenamiento f
JOIN Dim_TipoInstalacion d 
    ON f.id_tipo = d.id_tipo;


/* 
4) Consulta: Cuántas personas puede alimentar cada instalación

Objetivo:
Calcular cuántas personas puede alimentar cada tipo de instalación.

Pasos:
1. Calcular consumo promedio por persona:
   consumo_promedio = SUM(consumo_total_kg_dia) / SUM(personas)

2. Dividir la capacidad total (kg) entre el consumo promedio.

Notas:
- DECIMAL asegura precisión en cálculos nutricionales.
*/

SELECT 
    d.nombre_tipo AS tipo_instalacion,                 -- Tipo de instalación
    f.capacidad_total_toneladas * 1000 AS capacidad_kg, -- Capacidad total en kg
    
    /* 
    Personas que puede alimentar:
    capacidad_total_kg / consumo_promedio_por_persona
    */
    (f.capacidad_total_toneladas * 1000) /
    (
        SELECT SUM(consumo_total_kg_dia) / SUM(personas)
        FROM Fact_Consumo
    ) AS personas_que_puede_alimentar
FROM Fact_Almacenamiento f
JOIN Dim_TipoInstalacion d 
    ON f.id_tipo = d.id_tipo;


/* 
5) Consulta: Días de autonomía total de Valdoria

Objetivo:
Calcular cuántos días puede sobrevivir Valdoria con TODAS las instalaciones combinadas.

Fórmula:
dias_autonomia_total = capacidad_total_kg / consumo_total_diario_kg
*/

SELECT 
    (SUM(capacidad_total_toneladas) * 1000) /          -- Convertir a kg
    (SELECT SUM(consumo_total_kg_dia) FROM Fact_Consumo)
        AS dias_autonomia_total
FROM Fact_Almacenamiento;

/*
⭐ Conclusiones clave para la toma de decisiones (Valdoria)
1) La ciudad tiene una autonomía alimentaria sólida a corto y medio plazo
Con 335 toneladas de almacenamiento y un consumo diario de 2.079 kg:

Autonomía total ≈ 161 días (5.3 meses)  
Esto indica que Valdoria puede soportar interrupciones temporales en la producción o el suministro externo.

Decisión:
Mantener el nivel actual de reservas es estratégico.

Se recomienda evaluar escenarios de crisis para determinar si 5 meses es suficiente según riesgos climáticos o políticos.

2) Los graneros son la infraestructura crítica del sistema alimentario
Los graneros aportan:

240 toneladas (71% del total)

115 días de autonomía por sí solos

Decisión:
Priorizar mantenimiento, seguridad y ampliación de graneros.

Evaluar vulnerabilidades (incendios, plagas, humedad).

Considerar diversificar para reducir dependencia de un solo tipo de instalación.

3) Las cámaras frías aportan estabilidad nutricional, no volumen
Aportan:

60 toneladas

28 días de autonomía

Pero su valor real está en:

conservación de alimentos perecederos

equilibrio nutricional

reducción de desperdicio

Decisión:
Invertir en eficiencia energética y capacidad de refrigeración.

Aumentar su capacidad si se prevé mayor producción de perecederos.

4) El banco de semillas es simbólico en volumen, pero estratégico
Solo aporta:

5 toneladas

2 días de autonomía

Pero su función es:

garantizar la continuidad agrícola

permitir replantación tras crisis

preservar biodiversidad local

Decisión:
Mantenerlo como infraestructura estratégica.

No depende de volumen, sino de seguridad y conservación.

5) La reserva estratégica es un amortiguador importante
Aporta:

30 toneladas

14 días de autonomía

Es clave para:

emergencias

picos de demanda

fallos en la cadena de suministro

Decisión:
Evaluar si 14 días es suficiente como "colchón".

Considerar ampliarla si se anticipan riesgos.

6) El grupo de trabajadores es el mayor consumidor
Consumo diario:

Trabajadores: 1210 kg/día (58% del total)

Le siguen estudiantes, niños y ancianos.

Decisión:
Cualquier política que afecte a la fuerza laboral impacta directamente en la demanda alimentaria.

Planificar reservas específicas para este grupo en caso de crisis.

7) El consumo promedio por persona es ≈ 0.99 kg/día
Esto permite:

estimar necesidades futuras

modelar crecimiento poblacional

planificar producción agrícola

Decisión:
Usar este valor como base para simulaciones de escenarios.

Ajustarlo si cambian hábitos alimentarios o composición demográfica.

8) La capacidad actual permite alimentar a toda la población durante meses
Con 335.000 kg disponibles y un consumo promedio de 0.99 kg/persona/día:

La infraestructura puede alimentar a ≈338.000 personas durante un día

O a la población actual durante 161 días

Decisión:
La capacidad es suficiente, pero depende de la estabilidad del consumo.

Si la población crece, la autonomía disminuirá proporcionalmente.

⭐ Conclusión ejecutiva
Valdoria 