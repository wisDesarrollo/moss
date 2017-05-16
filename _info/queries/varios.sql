SELECT SUM(`total`) FROM `transaccion` WHERE id_transaccion IN(1,3,29,28,27,26,24,23,22,21,20,12,11,10,9, 19,8,18,17,15,14,13,6)

/*REPORTE */
SELECT COUNT(id_transaccion) AS cantidad, SUM(total) AS subtotal, SUM(servicio) AS servicio, SUM(total+servicio) AS TOTAL  FROM `transaccion` WHERE `fecha` >= '2017-04-13 00:00:00' 