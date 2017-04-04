-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-02-2016 a las 15:03:22
-- Versión del servidor: 5.5.32
-- Versión de PHP: 5.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `codigo_respuesta`
--

CREATE TABLE IF NOT EXISTS `codigo_respuesta` (
  `id_codigo_respuesta` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(4) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_codigo_respuesta`),
  KEY `index_code` (`codigo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=54 ;

--
-- Volcado de datos para la tabla `codigo_respuesta`
--

INSERT INTO `codigo_respuesta` (`id_codigo_respuesta`, `codigo`, `descripcion`) VALUES
(1, '010', 'Error; Error al editar registro'),
(2, '011', 'Error; Error al crear registro'),
(3, '012', 'Error; Error al eliminar registro'),
(4, '013', 'Transaccion Exitosa; Elemento editado correctamente'),
(5, '014', 'Transaccion Exitosa; Elemento creado  correctamente'),
(6, '015', 'Transaccion Exitosa; Elemento(s) eliminado(s) correctamente'),
(16, '016', 'Error; La clave actual no coincide'),
(17, '017', 'Transaccion Exitosa; Clave cambiada correctamente'),
(18, '007', 'Autenticacion; Usuario y/o clave incorrecta'),
(19, '009', 'Ha excedido el numero de intentos permitidos, su usuario ha sido bloqueado'),
(20, '008', 'Su usuario se encuentra bloqueado'),
(21, '001', 'Interconexion Exitosa'),
(22, '002', 'Error al actualizar la transaccion'),
(23, '003', 'Transaccion exitosa'),
(24, '004', 'Error; Error al guardar transaccion'),
(25, '005', 'Error; Error en la interconexion'),
(26, '006', 'Saldo insuficiente'),
(27, '026', 'El usuario ya existe'),
(29, '030', 'Transaccion Exitosa; Destinatario creado correctamente'),
(30, '031', 'Transaccion Exitosa; Destinatario editado correctamente'),
(31, '032', 'Transaccion Exitosa; Destinatario(s) eliminado(s) correctamente'),
(32, '033', 'Transaccion Exitosa; Mensaje creado correctamente'),
(33, '034', 'Transaccion Exitosa; Mensaje editado correctamente'),
(34, '035', 'Transaccion Exitosa; Mensajes(s) eliminado(s) correctamente'),
(35, '036', 'Transaccion Exitosa; Grupo creado correctamente'),
(36, '037', 'Transaccion Exitosa; Grupo editado correctamente'),
(37, '038', 'Transaccion Exitosa; Grupo(s) eliminado(s) correctamente'),
(38, '039', 'Transaccion Exitosa; Campaña creada correctamente'),
(39, '040', 'Transaccion Exitosa; Campaña editada correctamente'),
(40, '041', 'Transaccion Exitosa; Campaña(s) eliminada(s) correctamente'),
(41, '042', 'Transaccion Exitosa; Solicitud enviada correctamente'),
(42, '043', 'Transaccion Exitosa; Solicitud(es) eliminada(s) correctamente'),
(43, '044', 'Transaccion Exitosa; Usuario creado correctamente'),
(44, '045', 'Transaccion Exitosa; Usuario editado correctamente'),
(45, '046', 'Transaccion Exitosa; Usuario(s) eliminado(s) correctamente'),
(46, '047', 'Transaccion Exitosa; Proveedor creado correctamente'),
(47, '048', 'Transaccion Exitosa; Proveedor editado correctamente'),
(48, '049', 'Transaccion Exitosa; Proveedor(es) eliminado(s) correctamente'),
(49, '050', 'Transaccion Exitosa; Cliente creado correctamente'),
(50, '051', 'Transaccion Exitosa; Cliente editado correctamente'),
(51, '052', 'Transaccion Exitosa; Cliente(s) eliminado(s) correctamente'),
(52, '053', 'Esta mesa ya posee un pedido activo'),
(53, '054', 'Su pedido se encuentra vacio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE IF NOT EXISTS `configuracion` (
  `id_configuracion` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(10) unsigned zerofill NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `valor` varchar(20) DEFAULT NULL,
  `estado_id` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_configuracion`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id_configuracion`, `usuario_id`, `nombre`, `valor`, `estado_id`) VALUES
(1, 0000000004, 'titulo_sitio', 'MOSS', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE IF NOT EXISTS `estado` (
  `id_estado` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL DEFAULT '0000000000',
  `nombre` varchar(3) DEFAULT NULL,
  `descripcion` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`id_estado`, `interlocutor_id`, `nombre`, `descripcion`) VALUES
(1, 0000000000, 'A', 'Activo'),
(2, 0000000000, 'B', 'Bloqueado'),
(3, 0000000000, 'E', 'Eliminado'),
(5, 0000000000, 'Pe', 'Pendiente'),
(6, 0000000000, 'En', 'Enviado'),
(7, 0000000000, 'Ej', 'Ejecucion'),
(8, 0000000000, 'Su', 'Suspendido'),
(9, 0000000000, 'Re', 'Rechazada'),
(10, 0000000000, 'Ap', 'Aprobada'),
(11, 0000000000, 'dis', 'disponible'),
(12, 0000000000, 'res', 'reservado'),
(13, 0000000000, 'oc', 'ocupado'),
(14, 0000000000, 'esp', 'En espera'),
(15, 0000000000, 'des', 'Por pagar'),
(16, 0000000000, 'pp', 'En cocina'),
(17, 0000000000, 'pg', 'pagado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interlocutor`
--

CREATE TABLE IF NOT EXISTS `interlocutor` (
  `id_interlocutor` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL,
  `nombre` varchar(30) NOT NULL DEFAULT '',
  `apellido` varchar(30) NOT NULL DEFAULT '',
  `interlocutor_clase_id` int(6) NOT NULL DEFAULT '5',
  `tipo_documento` enum('cedula','nit') NOT NULL DEFAULT 'cedula',
  `num_documento` varchar(10) NOT NULL DEFAULT '0',
  `direccion` varchar(60) DEFAULT '',
  `celular` varchar(10) NOT NULL DEFAULT '',
  `telefono` varchar(10) DEFAULT '',
  `estado_id` tinyint(3) NOT NULL DEFAULT '1',
  `orden` int(11) DEFAULT '0',
  `descripcion` varchar(200) DEFAULT NULL,
  `interlocutor_tipo_negocio_id` int(11) NOT NULL,
  `email` varchar(40) NOT NULL,
  PRIMARY KEY (`id_interlocutor`),
  KEY `index_owner_login` (`id_interlocutor`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `interlocutor`
--

INSERT INTO `interlocutor` (`id_interlocutor`, `interlocutor_id`, `nombre`, `apellido`, `interlocutor_clase_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `interlocutor_tipo_negocio_id`, `email`) VALUES
(0000000001, 0000000000, 'HERMAN ', 'TORRES', 1, 'cedula', '1089378345', 'calle 124', '3125657845', '3425671', 1, 0, '', 1, 'herman.torres@gmail.com'),
(0000000002, 0000000001, 'antonio', 'rodriguez', 2, 'cedula', '1098334547', 'calle 14 No 32-14', '3145650902', '3425690', 1, 0, 'restaurante por el centro', 3, 'antonio.r2011@gmail.com'),
(0000000003, 0000000001, 'Bar ', 'Code', 2, 'nit', '1088243867', 'calle 23 No 4-23 sur', '3145675892', '3412563', 1, 1, 'bar de prueba', 2, 'daniel.p_2407@hotmail.com'),
(0000000004, 0000000000, 'comercio', '1', 2, 'nit', '258479658', 'carrera 4 calle 34-12', '3218895568', '3469586', 1, 2, 'comercio prueba', 1, 'prueba@gmail.com'),
(0000000005, 0000000000, 'proveedor1', '', 3, 'cedula', '108859659', 'calle 3ra 1-25', '3215896598', '3256986', 1, 1, 'vende cosas', 0, ''),
(0000000006, 0000000000, 'Chagualo', '', 3, 'cedula', '123456', 'chalito', '3112549867', '3649657', 1, 2, '', 0, ''),
(0000000007, 0000000000, 'asds', '', 3, 'cedula', 'asdasd', 'asdasd', '4444444444', '444444444', 1, 0, 'asdas', 0, ''),
(0000000008, 0000000000, 'Proveedor 1', '', 3, 'cedula', '5464654', '5646656', '6545646545', '56465456', 1, 11, '', 0, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interlocutor_clase`
--

CREATE TABLE IF NOT EXISTS `interlocutor_clase` (
  `id_interlocutor_clase` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  UNIQUE KEY `id_interlocutor_clase` (`id_interlocutor_clase`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `interlocutor_clase`
--

INSERT INTO `interlocutor_clase` (`id_interlocutor_clase`, `nombre`) VALUES
(1, 'administrador'),
(2, 'cliente'),
(3, 'proveedor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interlocutor_condicion`
--

CREATE TABLE IF NOT EXISTS `interlocutor_condicion` (
  `id_interlocutor_condicion` int(10) NOT NULL AUTO_INCREMENT,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL,
  `tema_id` int(8) NOT NULL DEFAULT '1',
  `titulo_sitio` varchar(25) NOT NULL DEFAULT '',
  `imagen_perfil` varchar(40) NOT NULL DEFAULT '',
  `imagen_logo` varchar(40) NOT NULL DEFAULT '',
  `marca_blanca` int(10) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id_interlocutor_condicion`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `interlocutor_condicion`
--

INSERT INTO `interlocutor_condicion` (`id_interlocutor_condicion`, `interlocutor_id`, `tema_id`, `titulo_sitio`, `imagen_perfil`, `imagen_logo`, `marca_blanca`) VALUES
(1, 0000000001, 2, 'WIS:: FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000001),
(2, 0000000002, 3, 'WIS:: FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000001),
(3, 0000000003, 2, 'WIS::FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000000),
(4, 0000000004, 1, 'WIS::FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interlocutor_tipo_negocio`
--

CREATE TABLE IF NOT EXISTS `interlocutor_tipo_negocio` (
  `id_interlocutor_tipo_negocio` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  UNIQUE KEY `id_interlocutor_tipo_negocio` (`id_interlocutor_tipo_negocio`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `interlocutor_tipo_negocio`
--

INSERT INTO `interlocutor_tipo_negocio` (`id_interlocutor_tipo_negocio`, `nombre`, `descripcion`) VALUES
(1, 'comercio', 'establecimientos de compra y venta directa de productos'),
(2, 'Bar', 'establecimiento de venta de licores'),
(3, 'restaurante', 'Establecimiento que ofrece servicios de alimentacion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log`
--

CREATE TABLE IF NOT EXISTS `log` (
  `id_log` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_log_id` tinyint(3) NOT NULL,
  `usuario_id` int(10) unsigned zerofill NOT NULL,
  `comentario` varchar(45) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(15) NOT NULL,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1321 ;

--
-- Volcado de datos para la tabla `log`
--

INSERT INTO `log` (`id_log`, `tipo_log_id`, `usuario_id`, `comentario`, `descripcion`, `fecha`, `ip`) VALUES
(1264, 1, 0000000001, 'appadmin', '', '2016-01-30 23:56:18', '186.145.35.156'),
(1265, 1, 0000000004, 'bar1', '', '2016-01-30 23:59:15', '186.145.35.156'),
(1266, 2, 0000000000, 'chavelastexmex', '111111', '2016-01-31 00:01:37', '186.145.35.156'),
(1267, 1, 0000000002, 'antoniorodriguez', '', '2016-01-31 00:03:17', '186.145.35.156'),
(1268, 1, 0000000004, 'bar1', '', '2016-01-31 02:19:20', '181.51.129.98'),
(1269, 3, 0000000004, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''M1'' ,  ''M1'' ,  ''11'' ,  ''1'' ,  '''' ,  ''0000000003'' )', '2016-01-31 02:20:51', '181.51.129.98'),
(1270, 1, 0000000004, 'bar1', '', '2016-01-31 04:10:35', '186.85.210.206'),
(1271, 3, 0000000004, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''Mesa 2'' ,  '''' ,  ''11'' ,  ''2'' ,  '''' ,  ''0000000003'' )', '2016-01-31 04:11:18', '186.85.210.206'),
(1272, 3, 0000000004, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''Mesa 3'' ,  '''' ,  ''11'' ,  ''3'' ,  '''' ,  ''0000000003'' )', '2016-01-31 04:11:36', '186.85.210.206'),
(1273, 3, 0000000004, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''Mesa 4'' ,  '''' ,  ''11'' ,  ''4'' ,  '''' ,  ''0000000003'' )', '2016-01-31 04:11:57', '186.85.210.206'),
(1274, 3, 0000000004, 'interlocutor', '`(`interlocutor_clase_id`, `nombre`, `num_documento`, `direccion`, `telefono`, `celular`, `estado_id`, `orden`, `descripcion`) VALUES ( ''3'' ,  ''Chagualo'' ,  ''123456'' ,  ''chalito'' ,  ''3649657'' ,  ''3112549867'' ,  ''1'' ,  ''2'' ,  '''' )', '2016-01-31 04:15:12', '186.85.210.206'),
(1275, 5, 0000000004, 'mesa', '`estado_id` = ''3'' WHERE  id_mesa=106 OR id_mesa=108', '2016-01-31 04:23:42', '186.85.210.206'),
(1276, 5, 0000000004, 'mesa', '`estado_id` = ''3'' WHERE  id_mesa=107', '2016-01-31 04:23:53', '186.85.210.206'),
(1277, 3, 0000000004, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''M1'' ,  '''' ,  ''11'' ,  ''1'' ,  '''' ,  ''0000000003'' )', '2016-01-31 04:24:06', '186.85.210.206'),
(1278, 3, 0000000004, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''Mesa 2'' ,  '''' ,  ''11'' ,  ''2'' ,  '''' ,  ''0000000003'' )', '2016-01-31 04:24:20', '186.85.210.206'),
(1279, 5, 0000000004, 'mesa', '`estado_id` = ''3'' WHERE  id_mesa=111', '2016-01-31 04:24:25', '186.85.210.206'),
(1280, 3, 0000000004, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''M2'' ,  '''' ,  ''11'' ,  ''2'' ,  '''' ,  ''0000000003'' )', '2016-01-31 04:24:38', '186.85.210.206'),
(1281, 3, 0000000004, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''M3'' ,  '''' ,  ''11'' ,  ''3'' ,  '''' ,  ''0000000003'' )', '2016-01-31 04:24:48', '186.85.210.206'),
(1282, 3, 0000000004, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `precio`, `estado_id`, `orden`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Guaro'' ,  ''Guaro'' ,  ''1200'' ,  ''1'' ,  ''1'' ,  '''' ,  ''0000000003'' )', '2016-01-31 04:26:34', '186.85.210.206'),
(1283, 3, 0000000004, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `precio`, `estado_id`, `orden`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Cerveza Pilsen'' ,  ''Pilsen'' ,  ''2500'' ,  ''1'' ,  ''2'' ,  '''' ,  ''0000000003'' )', '2016-01-31 04:27:00', '186.85.210.206'),
(1284, 3, 0000000004, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `precio`, `estado_id`, `orden`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Aguila ligt'' ,  ''Aguila L'' ,  ''2500'' ,  ''1'' ,  ''3'' ,  '''' ,  ''0000000003'' )', '2016-01-31 04:27:33', '186.85.210.206'),
(1285, 3, 0000000004, 'observacion', '`(`nombre`, `orden`, `estado_id`, `interlocutor_id`) VALUES ( ''cerveza'' ,  ''1'' ,  ''1'' ,  ''0000000003'' )', '2016-01-31 04:29:15', '186.85.210.206'),
(1286, 5, 0000000004, 'producto', '`estado_id` = ''3'' WHERE  id_producto=199', '2016-01-31 04:29:40', '186.85.210.206'),
(1287, 1, 0000000004, 'Bar1', '', '2016-02-02 02:07:30', '181.60.17.103'),
(1288, 1, 0000000004, 'bar1', '', '2016-02-02 20:24:08', '190.128.60.157'),
(1289, 1, 0000000004, 'bar1', '', '2016-02-03 14:56:08', '190.128.60.157'),
(1290, 1, 0000000004, 'bar1', '', '2016-02-05 12:15:43', '190.128.60.157'),
(1291, 1, 0000000001, 'appadmin', '', '2016-02-10 14:28:09', '186.81.131.169'),
(1292, 1, 0000000001, 'appadmin', '', '2016-02-11 04:46:50', '::1'),
(1293, 2, 0000000000, 'mesero', '111111', '2016-02-11 04:47:50', '::1'),
(1294, 1, 0000000005, 'mesero1', '', '2016-02-11 04:48:33', '::1'),
(1295, 1, 0000000004, 'bar1', '', '2016-02-11 04:50:37', '::1'),
(1296, 1, 0000000005, 'mesero1', '', '2016-02-11 04:52:20', '::1'),
(1297, 1, 0000000001, 'appadmin', '', '2016-02-11 04:53:21', '::1'),
(1298, 1, 0000000004, 'bar1', '', '2016-02-11 14:35:17', '::1'),
(1299, 1, 0000000004, 'bar1', '', '2016-02-11 15:26:32', '::1'),
(1300, 1, 0000000004, 'bar1', '', '2016-02-11 15:33:50', '::1'),
(1301, 3, 0000000004, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''Bebidas'' ,  ''1'' ,  ''Bebidas'' ,  ''1'' ,  ''0000000003'' )', '2016-02-11 17:40:29', '::1'),
(1302, 3, 0000000004, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `producto_categoria_id`, `precio`, `estado_id`, `orden`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Club Colombia'' ,  ''Club'' ,  ''10'' ,  ''5000'' ,  ''1'' ,  ''5'' ,  ''CC'' ,  ''0000000003'' )', '2016-02-11 17:41:09', '::1'),
(1303, 3, 0000000004, 'interlocutor', '`(`interlocutor_clase_id`, `nombre`, `num_documento`, `direccion`, `telefono`, `celular`, `estado_id`, `orden`, `descripcion`) VALUES ( ''3'' ,  ''asds'' ,  ''asdasd'' ,  ''asdasd'' ,  ''444444444'' ,  ''444444444444'' ,  ''1'' ,  ''asdas'' ,  ''asdas'' )', '2016-02-11 17:53:21', '::1'),
(1304, 3, 0000000004, 'interlocutor', '`(`interlocutor_clase_id`, `nombre`, `num_documento`, `direccion`, `telefono`, `celular`, `estado_id`, `orden`, `descripcion`) VALUES ( ''3'' ,  ''Proveedor 1'' ,  ''5464654'' ,  ''5646656'' ,  ''56465456'' ,  ''65456465456'' ,  ''1'' ,  ''11'' ,  '''' )', '2016-02-13 04:01:27', '127.0.0.1'),
(1305, 3, 0000000004, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''Cocteles'' ,  ''6'' ,  ''c'' ,  ''1'' ,  ''0000000003'' )', '2016-02-13 04:39:46', '127.0.0.1'),
(1306, 3, 0000000004, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''Trago corto'' ,  ''7'' ,  ''TC'' ,  ''1'' ,  ''0000000003'' )', '2016-02-13 04:40:13', '127.0.0.1'),
(1307, 3, 0000000004, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `producto_categoria_id`, `precio`, `estado_id`, `orden`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Cuba Libre'' ,  ''Cuba'' ,  ''11'' ,  ''5000'' ,  ''1'' ,  ''4'' ,  '''' ,  ''0000000003'' )', '2016-02-13 04:41:02', '127.0.0.1'),
(1308, 3, 0000000004, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `producto_categoria_id`, `precio`, `estado_id`, `orden`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Tekila'' ,  ''TK'' ,  ''12'' ,  ''2000'' ,  ''1'' ,  ''6'' ,  '''' ,  ''0000000003'' )', '2016-02-13 04:41:43', '127.0.0.1'),
(1309, 3, 0000000004, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `producto_categoria_id`, `precio`, `estado_id`, `orden`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Guaro'' ,  ''G'' ,  ''12'' ,  ''3000'' ,  ''1'' ,  ''6'' ,  '''' ,  ''0000000003'' )', '2016-02-13 04:42:05', '127.0.0.1'),
(1310, 1, 0000000001, 'appadmin', '', '2016-02-13 04:43:34', '127.0.0.1'),
(1311, 1, 0000000005, 'mesero1', '', '2016-02-13 04:49:28', '127.0.0.1'),
(1312, 1, 0000000004, 'bar1', '', '2016-02-13 04:50:08', '127.0.0.1'),
(1313, 1, 0000000005, 'mesero1', '', '2016-02-17 13:30:53', '::1'),
(1314, 1, 0000000005, 'mesero1', '', '2016-02-17 13:30:56', '::1'),
(1315, 1, 0000000001, 'appadmin', '', '2016-02-17 14:17:29', '::1'),
(1316, 1, 0000000005, 'mesero1', '', '2016-02-18 21:49:19', '::1'),
(1317, 1, 0000000005, 'mesero1', '', '2016-02-19 04:27:36', '::1'),
(1318, 1, 0000000004, 'bar1', '', '2016-02-21 18:24:26', '::1'),
(1319, 1, 0000000004, 'bar1', '', '2016-02-22 02:05:24', '::1'),
(1320, 1, 0000000004, 'bar1', '', '2016-02-22 13:04:20', '::1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_tipo`
--

CREATE TABLE IF NOT EXISTS `log_tipo` (
  `id_log_tipo` tinyint(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_log_tipo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `log_tipo`
--

INSERT INTO `log_tipo` (`id_log_tipo`, `nombre`) VALUES
(1, 'ingreso'),
(2, 'ingreso fallido'),
(3, 'crerar'),
(4, 'editar'),
(5, 'borrar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mesa`
--

CREATE TABLE IF NOT EXISTS `mesa` (
  `id_mesa` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `estado_id` tinyint(4) NOT NULL DEFAULT '11',
  `mesero_id` int(11) NOT NULL DEFAULT '0',
  `orden` int(11) NOT NULL,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id_mesa`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=114 ;

--
-- Volcado de datos para la tabla `mesa`
--

INSERT INTO `mesa` (`id_mesa`, `nombre`, `descripcion`, `estado_id`, `mesero_id`, `orden`, `interlocutor_id`) VALUES
(1, '1', '', 11, 0, 0, 0000000001),
(2, '2', '', 11, 0, 1, 0000000001),
(3, '3', '', 11, 0, 2, 0000000001),
(4, '4', '', 11, 0, 3, 0000000001),
(5, '5', '', 11, 0, 4, 0000000001),
(6, '6', '', 11, 0, 5, 0000000001),
(7, '7', '', 11, 0, 6, 0000000001),
(8, '8', '', 11, 0, 7, 0000000001),
(9, '9', '', 3, 0, 8, 0000000001),
(10, '10', '', 3, 0, 9, 0000000001),
(11, '11', '', 11, 0, 10, 0000000001),
(101, '13', '13', 11, 0, 13, 0000000001),
(102, '1', '1', 13, 0, 0, 0000000002),
(103, '2', '2', 11, 0, 2, 0000000002),
(104, '3', '3', 3, 0, 3, 0000000002),
(105, '5', '5', 11, 0, 5, 0000000002),
(106, 'M1', 'M1', 3, 0, 1, 0000000003),
(107, 'Mesa 2', '', 3, 0, 2, 0000000003),
(108, 'Mesa 3', '', 3, 0, 3, 0000000003),
(109, 'Mesa 4', '', 13, 0, 4, 0000000003),
(110, 'M1', '', 13, 0, 1, 0000000003),
(111, 'Mesa 2', '', 3, 0, 2, 0000000003),
(112, 'M2', '', 13, 0, 2, 0000000003),
(113, 'M3', '', 11, 0, 3, 0000000003);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `observacion`
--

CREATE TABLE IF NOT EXISTS `observacion` (
  `id_observacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `orden` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '1',
  `interlocutor_id` int(10) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id_observacion`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=72 ;

--
-- Volcado de datos para la tabla `observacion`
--

INSERT INTO `observacion` (`id_observacion`, `nombre`, `orden`, `estado_id`, `interlocutor_id`) VALUES
(54, 'entrada', 19, 1, 0000000001),
(45, 'sin sour', 10, 1, 0000000001),
(53, 'sin chorizo', 12, 1, 0000000002),
(52, 'sin salsas', 13, 1, 0000000002),
(51, 'sin queso', 8, 3, 0000000000),
(50, 'sin cilantro', 7, 1, 0000000000),
(49, 'sin tomate', 14, 1, 0000000000),
(48, 'vaso con agua', 32, 1, 0000000000),
(47, 'con hielo', 31, 1, 0000000000),
(46, 'sin guaca', 11, 1, 0000000000),
(44, 'sin refrito', 9, 1, 0000000000),
(43, 'con endulzante', 30, 1, 0000000000),
(69, 'sin ripiose', 2, 3, 0000000000),
(70, 'lechuga', 2, 3, 0000000000),
(71, 'cerveza', 1, 1, 0000000003);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opcion`
--

CREATE TABLE IF NOT EXISTS `opcion` (
  `id_opcion` int(30) NOT NULL AUTO_INCREMENT,
  `opcion_id` varchar(15) DEFAULT NULL,
  `opcion_categoria_id` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `imagen` varchar(60) DEFAULT NULL,
  `estado_id` tinyint(3) unsigned DEFAULT NULL,
  `orden` int(20) DEFAULT NULL,
  `titulo` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id_opcion`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Volcado de datos para la tabla `opcion`
--

INSERT INTO `opcion` (`id_opcion`, `opcion_id`, `opcion_categoria_id`, `descripcion`, `imagen`, `estado_id`, `orden`, `titulo`) VALUES
(1, '0', 5, 'administracion', '1.png', 1, 1, 'administracion'),
(2, '1', 5, 'transaccion', 'reporte_2.png', 1, 2, 'transaccion'),
(3, '4', 5, 'inventario fisico', '3.png', 1, 3, 'inventario fisico'),
(4, '0', 0, 'reportes', 'reporte_3.png', 1, 4, 'reportes'),
(5, '1', 0, 'Configuración', NULL, 1, 50, 'configuracion'),
(7, '1', 0, 'proveedores', '12.png', 1, 6, 'proveedor'),
(8, '1', 0, 'Usuarios', '2.png', 1, 8, 'usuario'),
(9, '17', 0, 'observaciones', 'administracion_2.png', 1, 9, 'observacion'),
(10, '17', 0, 'producto', '3.png', 1, 10, 'producto'),
(11, '4', 0, 'reporte ventas', 'reporte_2.png', 1, 11, 'reporte_ventas'),
(12, '4', 0, 'reporte compras', '5.png', 1, 12, 'reporte_compras'),
(13, '4', 0, 'reporte inventario', '3.png', 1, 13, 'inventario'),
(14, '1', 5, 'mesas', 'mesas.png', 1, 14, 'mesas'),
(15, '17', 1, 'Toma de Pedidos', 'mesas.png', 1, 15, 'mesas_visual'),
(16, '17', 1, 'Categorias productos', '2.png', 1, 14, 'producto_categoria'),
(17, '0', 0, 'operacion', '1.png', 1, 4, 'operacion'),
(18, '1', 0, 'Interlocutores', '1.png', 1, 0, 'interlocutor'),
(19, '17', 0, 'comandas', '1.png', 1, 7, 'comandas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opcion_categoria`
--

CREATE TABLE IF NOT EXISTS `opcion_categoria` (
  `id_opcion_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `estado_id` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  PRIMARY KEY (`id_opcion_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opcion_clase`
--

CREATE TABLE IF NOT EXISTS `opcion_clase` (
  `opcion_id` int(30) NOT NULL DEFAULT '0',
  `interlocutor_clase_id` int(6) NOT NULL,
  `estado_id` tinyint(3) unsigned DEFAULT '1',
  `usuario_perfil_id` int(11) NOT NULL,
  PRIMARY KEY (`opcion_id`,`interlocutor_clase_id`,`usuario_perfil_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `opcion_clase`
--

INSERT INTO `opcion_clase` (`opcion_id`, `interlocutor_clase_id`, `estado_id`, `usuario_perfil_id`) VALUES
(2, 2, 1, 1),
(4, 2, 1, 0),
(5, 2, 1, 1),
(7, 2, 1, 1),
(8, 2, 1, 1),
(9, 2, 1, 1),
(10, 2, 1, 1),
(11, 2, 1, 1),
(12, 2, 1, 1),
(13, 2, 1, 1),
(14, 2, 1, 1),
(15, 2, 1, 1),
(15, 2, 1, 2),
(16, 2, 1, 1),
(16, 2, 1, 2),
(17, 2, 1, 1),
(18, 1, 1, 1),
(19, 2, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE IF NOT EXISTS `pedido` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `mesero_id` int(11) NOT NULL,
  `mesa_id` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '16',
  `fecha_publicacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_despachado` datetime DEFAULT NULL,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id_pedido`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=162 ;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `mesero_id`, `mesa_id`, `estado_id`, `fecha_publicacion`, `fecha_despachado`, `interlocutor_id`) VALUES
(155, 2, 104, 17, '2015-11-19 21:17:20', NULL, 0000000002),
(154, 2, 102, 17, '2015-11-19 21:16:39', NULL, 0000000002),
(156, 2, 102, 3, '2015-12-08 19:10:32', NULL, 0000000002),
(157, 2, 102, 17, '2015-12-20 20:02:15', NULL, 0000000002),
(158, 2, 102, 17, '2015-12-20 20:06:25', NULL, 0000000002),
(159, 2, 102, 17, '2015-12-22 16:13:17', NULL, 0000000002),
(160, 4, 110, 15, '2016-02-13 04:11:48', NULL, 0000000003),
(161, 5, 112, 16, '2016-02-17 13:32:05', NULL, 0000000003);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_item`
--

CREATE TABLE IF NOT EXISTS `pedido_item` (
  `id_pedido_item` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `observacion_id` int(11) NOT NULL DEFAULT '1',
  `estado_id` int(11) NOT NULL DEFAULT '16',
  PRIMARY KEY (`id_pedido_item`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=338 ;

--
-- Volcado de datos para la tabla `pedido_item`
--

INSERT INTO `pedido_item` (`id_pedido_item`, `pedido_id`, `producto_id`, `cantidad`, `observacion_id`, `estado_id`) VALUES
(319, 154, 193, 7, 53, 17),
(317, 154, 193, 3, 53, 3),
(318, 154, 193, 4, 53, 3),
(311, 155, 194, 3, 53, 17),
(310, 155, 192, 1, 53, 17),
(309, 155, 193, 2, 53, 17),
(308, 154, 194, 2, 53, 17),
(307, 154, 192, 2, 53, 17),
(320, 156, 192, 1, 53, 16),
(321, 156, 193, 1, 53, 16),
(322, 157, 192, 2, 53, 17),
(323, 157, 194, 1, 53, 17),
(324, 157, 193, 2, 53, 17),
(325, 158, 192, 3, 53, 17),
(326, 158, 194, 2, 53, 17),
(327, 158, 193, 1, 53, 17),
(328, 159, 192, 2, 53, 17),
(329, 159, 194, 3, 53, 17),
(330, 159, 193, 6, 53, 17),
(331, 160, 202, 2, 71, 15),
(332, 160, 202, 4, 71, 16),
(333, 160, 202, 4, 71, 16),
(334, 161, 204, 1, 71, 16),
(335, 161, 205, 1, 71, 16),
(336, 161, 203, 5, 71, 16),
(337, 161, 202, 3, 71, 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE IF NOT EXISTS `producto` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `nombre_corto` varchar(20) NOT NULL,
  `producto_categoria_id` int(11) NOT NULL,
  `precio` bigint(10) NOT NULL DEFAULT '0',
  `imagen` varchar(30) NOT NULL,
  `descripcion` longtext NOT NULL,
  `orden` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=206 ;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `nombre`, `nombre_corto`, `producto_categoria_id`, `precio`, `imagen`, `descripcion`, `orden`, `estado_id`, `interlocutor_id`) VALUES
(1, 'carne de res asada', 'res asada', 1, 20000, '1.jpg', '250 gramos de carne asada al carbon con el mejor sabor nuestro', 0, 1, 0000000001),
(2, 'cerveza poker', 'poker', 6, 2000, '', 'cerveza poker bien fria', 0, 1, 0000000001),
(3, 'postre de limon', 'postre limon', 4, 3000, '', 'delicioso postre de limon acompañado de galletas dulces', 1, 1, 0000000001),
(166, 'whiskey old par', 'old par', 6, 120000, '', 'Whiskey old par 12 años', 0, 1, 0000000001),
(167, 'qwerty', 'qwerty', 1, 1, '', 'qwety', 1, 3, 0000000001),
(168, 'cerdo asado', 'cerdo asado', 1, 10000, '', 'cerdo asado', 0, 1, 0000000001),
(169, 'postre de chocolate', 'postre chocolate', 4, 6000, '', 'chocolate', 0, 1, 0000000001),
(170, 'aguardiente antioqueño tapa azul', 'antioqueño azul', 6, 28000, '170.jpg', 'media de guaro', 0, 1, 0000000001),
(188, 'bandeja paisa', 'bandeja paisa', 2, 12000, '5jRoMs647560-02.jpg', 'bandeja paisa', 1, 1, 0000000001),
(189, 'carne a la parrilla', 'res asada', 1, 10000, '', 'carne muy buena', 0, 1, 0000000002),
(190, 'miller lite', 'miller', 6, 2000, '', 'cerveza miller lite helada', 1, 3, 0000000002),
(191, 'sancocho de leña', 'sancocho', 2, 9000, '', 'sancochito muy sabroso', 1, 3, 0000000002),
(192, 'margarita', 'margarita', 8, 3500, '', 'delicioso margarita', 0, 1, 0000000002),
(193, 'lasagna', 'lasagna', 9, 15000, '', 'deliciosa lasagna', 1, 1, 0000000002),
(194, 'cuba', 'cuba', 8, 3000, '', 'ron y limon', 2, 1, 0000000002),
(197, 'gorra', 'gorra tiesa', 0, 1244, '', 'gorra bacana', 0, 1, 0000000004),
(198, 'camisa', 'camisa', 0, 15965, '', 'camisa', 1, 1, 0000000004),
(199, 'Guaro', 'Guaro', 0, 1200, '', '', 1, 3, 0000000003),
(200, 'Cerveza Pilsen', 'Pilsen', 0, 2500, '', '', 2, 1, 0000000003),
(201, 'Aguila ligt', 'Aguila L', 0, 2500, '', '', 3, 1, 0000000003),
(202, 'Club Colombia', 'Club', 10, 5000, '', 'CC', 5, 1, 0000000003),
(203, 'Cuba Libre', 'Cuba', 11, 5000, '', '', 4, 1, 0000000003),
(204, 'Tekila', 'TK', 12, 2000, '', '', 6, 1, 0000000003),
(205, 'Guaro', 'G', 12, 3000, '', '', 6, 1, 0000000003);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_categoria`
--

CREATE TABLE IF NOT EXISTS `producto_categoria` (
  `id_producto_categoria` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(70) NOT NULL,
  `orden` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `interlocutor_id` int(11) NOT NULL,
  UNIQUE KEY `id_productos_categoria` (`id_producto_categoria`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `producto_categoria`
--

INSERT INTO `producto_categoria` (`id_producto_categoria`, `nombre`, `orden`, `estado_id`, `descripcion`, `interlocutor_id`) VALUES
(1, 'Parrilla', 0, 1, 'comidas asadas al carbon', 1),
(2, 'Platos Tipicoses', 0, 1, 'Peseslatos regionales y de mas', 1),
(3, 'Bebidas', 2, 1, 'Todo elemento liquido', 5),
(4, 'Postres', 3, 1, 'Postres', 1),
(5, 'comida de mares', 1, 1, 'platos que contengan igradientes extraidos del mar', 1),
(6, 'licores', 1, 1, 'bebidas que contienen alcohol', 1),
(7, 'jugos', 0, 3, 'acompañantes de las comidas', 2),
(8, 'cocteles', 0, 1, 'licores mezclados en forma de coctel', 2),
(9, 'italianos', 1, 1, 'comida italiana', 2),
(10, 'Bebidas', 1, 1, 'Bebidas', 3),
(11, 'Cocteles', 6, 1, 'c', 3),
(12, 'Trago corto', 7, 1, 'TC', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_stock`
--

CREATE TABLE IF NOT EXISTS `producto_stock` (
  `producto_id` int(11) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `producto_stock`
--

INSERT INTO `producto_stock` (`producto_id`, `stock`) VALUES
(1, 10),
(189, 20),
(192, 8),
(197, 18),
(198, 50),
(1, 10),
(189, 20),
(192, 8),
(197, 18),
(198, 50),
(199, 0),
(200, 0),
(201, 0),
(202, 0),
(203, 0),
(204, 0),
(205, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `referencias`
--

CREATE TABLE IF NOT EXISTS `referencias` (
  `id_referencias` int(11) NOT NULL AUTO_INCREMENT,
  `referencia` varchar(100) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `color_id` int(11) NOT NULL,
  `estado` set('A','B','E') NOT NULL,
  `orden` int(11) NOT NULL,
  PRIMARY KEY (`id_referencias`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `referencias`
--

INSERT INTO `referencias` (`id_referencias`, `referencia`, `nombre`, `descripcion`, `color_id`, `estado`, `orden`) VALUES
(1, '', 'MAGY LI MK', '', 0, 'E', 0),
(2, '', 'MONICA CABALLERO', '', 0, 'E', 0),
(3, 'blanco', 'blanco', '', 3, 'E', 0),
(4, 'SRM-1201', 'blanco', '', 3, 'E', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tema`
--

CREATE TABLE IF NOT EXISTS `tema` (
  `id_tema` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(30) DEFAULT NULL,
  `estado_id` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_tema`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `tema`
--

INSERT INTO `tema` (`id_tema`, `descripcion`, `estado_id`) VALUES
(1, 'comercio', 1),
(2, 'bar', 1),
(3, 'restaurante', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaccion`
--

CREATE TABLE IF NOT EXISTS `transaccion` (
  `id_transaccion` int(11) NOT NULL AUTO_INCREMENT,
  `transaccion_tipo_id` int(11) NOT NULL,
  `responsable_id` int(11) NOT NULL,
  `interlocutor_id` int(10) unsigned zerofill DEFAULT NULL,
  `observacion` text NOT NULL,
  `estado_id` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_transaccion`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=183 ;

--
-- Volcado de datos para la tabla `transaccion`
--

INSERT INTO `transaccion` (`id_transaccion`, `transaccion_tipo_id`, `responsable_id`, `interlocutor_id`, `observacion`, `estado_id`, `fecha`) VALUES
(166, 1, 0, 0000000002, '', 1, '2015-11-21 00:36:20'),
(167, 1, 0, 0000000002, '', 1, '2015-11-21 00:37:15'),
(176, 1, 0, 0000000004, '', 1, '2015-12-13 18:32:58'),
(177, 0, 0, 0000000004, '', 1, '2015-12-13 18:32:58'),
(178, 1, 0, 0000000002, '', 1, '2015-12-20 20:04:10'),
(179, 1, 0, 0000000002, '', 1, '2015-12-20 20:07:25'),
(180, 1, 0, 0000000002, '', 1, '2015-12-22 16:15:06'),
(181, 0, 0, 0000000003, '', 1, '2016-02-05 12:16:48'),
(182, 0, 0, 0000000003, '', 1, '2016-02-05 12:25:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaccion_item`
--

CREATE TABLE IF NOT EXISTS `transaccion_item` (
  `id_transaccion_item` int(11) NOT NULL AUTO_INCREMENT,
  `transaccion_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `valor_unitario` int(11) NOT NULL,
  `iva` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL,
  PRIMARY KEY (`id_transaccion_item`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=178 ;

--
-- Volcado de datos para la tabla `transaccion_item`
--

INSERT INTO `transaccion_item` (`id_transaccion_item`, `transaccion_id`, `producto_id`, `cantidad`, `valor_unitario`, `iva`, `estado_id`) VALUES
(158, 166, 192, 2, 3500, 0, 1),
(159, 166, 194, 2, 3000, 0, 1),
(160, 166, 193, 7, 15000, 0, 1),
(161, 167, 193, 2, 15000, 0, 1),
(162, 167, 192, 1, 3500, 0, 1),
(163, 167, 194, 3, 3000, 0, 1),
(168, 177, 198, 2, 15965, 0, 1),
(169, 178, 192, 2, 3500, 0, 1),
(170, 178, 194, 1, 3000, 0, 1),
(171, 178, 193, 2, 15000, 0, 1),
(172, 179, 192, 3, 3500, 0, 1),
(173, 179, 194, 2, 3000, 0, 1),
(174, 179, 193, 1, 15000, 0, 1),
(175, 180, 192, 2, 3500, 0, 1),
(176, 180, 194, 3, 3000, 0, 1),
(177, 180, 193, 6, 15000, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaccion_tipo`
--

CREATE TABLE IF NOT EXISTS `transaccion_tipo` (
  `id_transaccion_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `movimiento_tipo_id` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  PRIMARY KEY (`id_transaccion_tipo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `transaccion_tipo`
--

INSERT INTO `transaccion_tipo` (`id_transaccion_tipo`, `nombre`, `descripcion`, `movimiento_tipo_id`, `estado_id`, `orden`) VALUES
(1, 'VENTA', '', 0, 1, 3),
(2, 'COMPRA', '', 0, 1, 4),
(3, 'INGRESO', '', 0, 1, 2),
(4, 'SALIDA', '', 0, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL,
  `nickname` varchar(30) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `email` varchar(60) NOT NULL,
  `usuario_perfil_id` int(6) NOT NULL DEFAULT '1',
  `clave` varchar(40) NOT NULL,
  `estado_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `index_usuario_owner_login` (`interlocutor_id`,`id_usuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `interlocutor_id`, `nickname`, `nombre`, `apellido`, `num_documento`, `email`, `usuario_perfil_id`, `clave`, `estado_id`) VALUES
(0000000001, 0000000001, 'appadmin', 'HERMAN ', 'TORRES', '1089378345', 'herman.torres@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000002, 0000000002, 'antoniorodriguez', 'antonio', 'rodriguez', '10983345478', 'antonio.r2011@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000003, 0000000002, 'wdpinto', 'wilson', 'pinto', '1088293298', 'daniel.p_2407@hotmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000004, 0000000003, 'bar1', 'Code Bar Admin', 'Test', '1088243867', 'herman.torres@wisgroup.com.co', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000005, 0000000003, 'mesero1', 'laura', 'zuluaga', '1088011746', 'lauris.0906@hotmail.com', 2, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000006, 0000000002, 'mesero3', 'lauras', 'zuluagas', '1059689545', 'lau@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000007, 0000000002, 'mesero2', 'laura', 'zuluaga', '10596895', 'lau@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 3),
(0000000008, 0000000002, 'mesero2', 'laura', 'zuluaga', '10596895', 'lau@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 3),
(0000000009, 0000000002, 'mesero2', 'laura', 'zuluaga', '10596895', 'lau@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 3),
(0000000010, 0000000002, 'mesero2', 'laura', 'zuluaga', '10596895', 'lau@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 3),
(0000000011, 0000000002, 'mesero2', 'laura', 'zuluaga', '10596895', 'lau@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 3),
(0000000012, 0000000002, 'mesero2', 'laura', 'zuluaga', '10596895', 'lau@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 3),
(0000000013, 0000000002, 'mesero2', 'laura', 'zuluaga', '10596895', 'lau@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 3),
(0000000014, 0000000002, 'mesero2', 'laura', 'zuluaga', '10596895', 'lau@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 3),
(0000000015, 0000000002, 'mesero2', 'laura', 'zuluaga', '10596895', 'lau@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 3),
(0000000016, 0000000002, 'mesero2', 'andres', 'rios', '1089996335', 'andres356@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000017, 0000000004, 'comercio1', 'comercio', '1', '258479658', 'prueba@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_perfil`
--

CREATE TABLE IF NOT EXISTS `usuario_perfil` (
  `id_usuario_perfil` int(6) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `estado_id` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_usuario_perfil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario_perfil`
--

INSERT INTO `usuario_perfil` (`id_usuario_perfil`, `nombre`, `estado_id`) VALUES
(1, 'Administrador', 1),
(2, 'mesero', 1),
(3, 'caja', 1),
(4, 'cocina', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
