--WIS CAMBIOS
-- 2017/03/11
INSERT INTO `fw_estado` (`id_estado`, `interlocutor_id`, `nombre`, `descripcion`) VALUES (NULL, '0000000000', 'CE', 'Cerrada');



CREATE TABLE `caja` (
  `id_caja` int(11) NOT NULL,
  `interlocutor_id` int(10) UNSIGNED ZEROFILL NOT NULL,
  `base` int(11) NOT NULL,
  `compras` int(11) NOT NULL,
  `ventas` int(11) NOT NULL,
  `caja` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '18'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `caja`
--

INSERT INTO `caja` (`id_caja`, `interlocutor_id`, `base`, `compras`, `ventas`, `caja`, `fecha`, `hora`, `estado_id`) VALUES
(1, 0000000012, 0, 0, 0, 0, '0000-00-00', '00:00:00', 23),
(2, 0000000012, 0, 0, 0, 0, '2017-03-09', '00:00:00', 23),
(3, 0000000012, 0, 0, 0, 0, '2017-03-10', '00:00:00', 23),
(4, 0000000012, 0, 0, 0, 0, '2017-03-12', '00:00:00', 18),
(5, 0000000012, 0, 0, 0, 0, '2017-03-13', '00:00:00', 18);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `caja`
--
ALTER TABLE `caja`
  ADD PRIMARY KEY (`id_caja`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `caja`
--
ALTER TABLE `caja`
  MODIFY `id_caja` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
  
  
INSERT INTO `fw_opcion_clase` (`opcion_id`, `interlocutor_clase_id`, `estado_id`, `usuario_perfil_id`, `tipo_negocio_id`, `marca_blanca`) VALUES ('28', '2', '1', '1', '2', '0');
INSERT INTO `fw_opcion_clase` (`opcion_id`, `interlocutor_clase_id`, `estado_id`, `usuario_perfil_id`, `tipo_negocio_id`, `marca_blanca`) VALUES ('28', '2', '1', '1', '1', '0');
INSERT INTO `fw_opcion_clase` (`opcion_id`, `interlocutor_clase_id`, `estado_id`, `usuario_perfil_id`, `tipo_negocio_id`, `marca_blanca`) VALUES ('29', '2', '1', '1', '1', '0');
INSERT INTO `fw_opcion_clase` (`opcion_id`, `interlocutor_clase_id`, `estado_id`, `usuario_perfil_id`, `tipo_negocio_id`, `marca_blanca`) VALUES ('29', '2', '1', '1', '2', '0');
INSERT INTO `fw_opcion_clase` (`opcion_id`, `interlocutor_clase_id`, `estado_id`, `usuario_perfil_id`, `tipo_negocio_id`, `marca_blanca`) VALUES ('30', '2', '1', '1', '1', '0');
INSERT INTO `fw_opcion_clase` (`opcion_id`, `interlocutor_clase_id`, `estado_id`, `usuario_perfil_id`, `tipo_negocio_id`, `marca_blanca`) VALUES ('30', '2', '1', '1', '2', '0');
INSERT INTO `fw_pack` (`id_pack`, `nombre`, `estado_id`) VALUES (NULL, 'interlocutor', '1');
INSERT INTO `fw_opcion` (`id_opcion`, `opcion_id`, `tipo`, `opcion_categoria_id`, `opcion_tipo_id`, `base`, `pack_id`, `descripcion`, `imagen`, `icon_id`, `estado_id`, `orden`, `nombre_modulo`) 
VALUES (NULL, '1', 'ITEM', '0', '5', 'app', '7', 'Clientes', NULL, '1', '1', '1', 'cliente');
INSERT INTO `fw_opcion` (`id_opcion`, `opcion_id`, `tipo`, `opcion_categoria_id`, `opcion_tipo_id`, `base`, `pack_id`, `descripcion`, `imagen`, `icon_id`, `estado_id`, `orden`, `nombre_modulo`) 
VALUES (NULL, '1', 'ITEM', '0', '5', 'app', '7', 'Proveedores', NULL, '1', '1', '1', 'proveedor');
INSERT INTO `fw_opcion_tipo` (`id_opcion_tipo`, `nombre`, `estado_id`) VALUES (NULL, 'interlocutor', '1');
UPDATE `fw_opcion` SET `nombre_modulo` = 'proveedor2' WHERE `fw_opcion`.`id_opcion` = 7;