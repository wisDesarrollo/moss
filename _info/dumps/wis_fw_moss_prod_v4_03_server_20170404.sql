-- phpMyAdmin SQL Dump
-- version 4.0.10.14
-- http://www.phpmyadmin.net
--
-- Servidor: localhost:3306
-- Tiempo de generación: 04-04-2017 a las 13:02:23
-- Versión del servidor: 5.6.33-cll-lve
-- Versión de PHP: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `wis_fw_moss_prod_v4_03`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja`
--

CREATE TABLE IF NOT EXISTS `caja` (
  `id_caja` int(11) NOT NULL AUTO_INCREMENT,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL,
  `base` int(11) NOT NULL,
  `compras` int(11) NOT NULL,
  `ventas` int(11) NOT NULL,
  `caja` int(11) NOT NULL,
  `fecha_apertura` date NOT NULL,
  `hora_apertura` time NOT NULL,
  `fecha_cierre` date NOT NULL,
  `hora_cierre` time NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '18',
  PRIMARY KEY (`id_caja`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `caja`
--

INSERT INTO `caja` (`id_caja`, `interlocutor_id`, `base`, `compras`, `ventas`, `caja`, `fecha_apertura`, `hora_apertura`, `fecha_cierre`, `hora_cierre`, `estado_id`) VALUES
(1, 0000000012, 50000, 615000, 525000, 140000, '2017-03-20', '17:28:24', '2017-03-20', '17:31:12', 23),
(2, 0000000012, 50000, 0, 312500, -262500, '2017-03-22', '09:51:21', '2017-04-01', '17:47:27', 23),
(3, 0000000012, 50000, 0, 0, 50000, '2017-04-01', '17:47:45', '0000-00-00', '00:00:00', 18),
(4, 0000000010, 200000, 100000, 0, 300000, '2017-04-03', '14:04:28', '2017-04-03', '14:05:52', 23),
(5, 0000000010, 200000, 0, 0, 200000, '2017-04-03', '15:49:37', '0000-00-00', '00:00:00', 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta`
--

CREATE TABLE IF NOT EXISTS `cuenta` (
  `id_cuenta` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `interlocutor_cliente_id` int(11) NOT NULL,
  `interlocutor_owner_id` int(11) NOT NULL,
  `punto_atencion_id` int(11) NOT NULL,
  `usuario_mesero_id` int(11) NOT NULL,
  `servicio_incluido` set('SI','NO') NOT NULL DEFAULT 'NO',
  `fecha_apertura` datetime NOT NULL,
  `fecha_cierre` datetime NOT NULL,
  `estado_id` int(11) NOT NULL,
  PRIMARY KEY (`id_cuenta`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `cuenta`
--

INSERT INTO `cuenta` (`id_cuenta`, `interlocutor_cliente_id`, `interlocutor_owner_id`, `punto_atencion_id`, `usuario_mesero_id`, `servicio_incluido`, `fecha_apertura`, `fecha_cierre`, `estado_id`) VALUES
(00000000000000000001, 0, 10, 118, 0, 'NO', '2017-03-22 13:31:14', '0000-00-00 00:00:00', 20),
(00000000000000000002, 0, 10, 123, 0, 'NO', '2017-03-27 14:44:06', '0000-00-00 00:00:00', 20),
(00000000000000000003, 0, 10, 120, 0, 'NO', '2017-03-28 15:41:20', '0000-00-00 00:00:00', 20),
(00000000000000000004, 0, 10, 121, 0, 'NO', '2017-03-30 15:06:57', '0000-00-00 00:00:00', 20),
(00000000000000000005, 0, 10, 119, 0, 'NO', '2017-03-30 15:08:06', '0000-00-00 00:00:00', 20),
(00000000000000000006, 0, 10, 122, 0, 'NO', '2017-04-01 10:18:49', '0000-00-00 00:00:00', 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_numeracion`
--

CREATE TABLE IF NOT EXISTS `factura_numeracion` (
  `id_factura_numeracion` int(11) NOT NULL AUTO_INCREMENT,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL,
  `resolucion_numero` varchar(100) CHARACTER SET latin1 NOT NULL,
  `factura_actual` int(10) unsigned NOT NULL,
  `factura_minimo` int(10) unsigned NOT NULL,
  `factura_maximo` int(10) unsigned NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '18',
  PRIMARY KEY (`id_factura_numeracion`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `factura_numeracion`
--

INSERT INTO `factura_numeracion` (`id_factura_numeracion`, `interlocutor_id`, `resolucion_numero`, `factura_actual`, `factura_minimo`, `factura_maximo`, `estado_id`) VALUES
(1, 0000000004, '1', 0, 1, 1000, 3),
(2, 0000000012, '2', 228, 1, 1000, 18),
(3, 0000000012, '3', 1001, 1001, 2000, 18),
(4, 0000000012, '3', 1001, 1001, 2000, 3),
(5, 0000000012, '', 0, 0, 0, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_codigo_respuesta`
--

CREATE TABLE IF NOT EXISTS `fw_codigo_respuesta` (
  `id_codigo_respuesta` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(4) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_codigo_respuesta`),
  KEY `index_code` (`codigo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=59 ;

--
-- Volcado de datos para la tabla `fw_codigo_respuesta`
--

INSERT INTO `fw_codigo_respuesta` (`id_codigo_respuesta`, `codigo`, `descripcion`) VALUES
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
(53, '054', 'Su pedido se encuentra vacio'),
(54, '055', 'Esta mesa posee pedidos activos, por favor cancele los pedidos y vuelta a intentarlo'),
(55, '056', 'Su pedido ha sido facturado, para imprimir su factura de clic en el boton imprimir, en el cuadro de '),
(56, '057', 'Configuración guardada correctamente.'),
(57, '058', 'Estado modificado con éxito.'),
(58, '059', 'Error al modificar el estado, intentelo nuevamente.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_configuracion`
--

CREATE TABLE IF NOT EXISTS `fw_configuracion` (
  `id_configuracion` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(10) unsigned zerofill NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `valor` varchar(20) DEFAULT NULL,
  `estado_id` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_configuracion`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `fw_configuracion`
--

INSERT INTO `fw_configuracion` (`id_configuracion`, `usuario_id`, `nombre`, `valor`, `estado_id`) VALUES
(1, 0000000004, 'titulo_sitio', 'MOSS', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_estado`
--

CREATE TABLE IF NOT EXISTS `fw_estado` (
  `id_estado` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL DEFAULT '0000000000',
  `nombre` varchar(3) CHARACTER SET latin1 DEFAULT NULL,
  `descripcion` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Volcado de datos para la tabla `fw_estado`
--

INSERT INTO `fw_estado` (`id_estado`, `interlocutor_id`, `nombre`, `descripcion`) VALUES
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
(15, 0000000000, 'PT', 'Pedido Tomado'),
(16, 0000000000, 'PS', 'Pedido Servido'),
(17, 0000000000, 'PE', 'Pedido Entregado'),
(18, 0000000000, 'VG', 'Vigente'),
(19, 0000000000, 'VD', 'Vencida'),
(20, 0000000000, 'CA', 'Cuenta Abierta'),
(21, 0000000000, 'CC', 'Cuenta Cerrada'),
(22, 0000000000, 'Fc', 'Item Facturado'),
(23, 0000000000, 'CE', 'Cerrada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_fuente`
--

CREATE TABLE IF NOT EXISTS `fw_fuente` (
  `id_fuente` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `estado_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_fuente`),
  KEY `estado_id` (`estado_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `fw_fuente`
--

INSERT INTO `fw_fuente` (`id_fuente`, `descripcion`, `estado_id`) VALUES
(1, 'negro', 1),
(2, 'azul', 1),
(3, 'violeta', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_icons`
--

CREATE TABLE IF NOT EXISTS `fw_icons` (
  `id_icon` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(50) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `estado_id` int(11) NOT NULL,
  PRIMARY KEY (`id_icon`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=265 ;

--
-- Volcado de datos para la tabla `fw_icons`
--

INSERT INTO `fw_icons` (`id_icon`, `icon`, `nombre`, `estado_id`) VALUES
(1, 'glyphicon glyphicon-asterisk', 'asterisk', 1),
(2, 'glyphicon glyphicon-plus', 'plus', 1),
(3, 'glyphicon glyphicon-euro', 'euro', 1),
(4, 'glyphicon glyphicon-eur', 'eur', 1),
(5, 'glyphicon glyphicon-minus', 'minus', 1),
(6, 'glyphicon glyphicon-cloud', 'cloud', 1),
(7, 'glyphicon glyphicon-envelope', 'envelope', 1),
(8, 'glyphicon glyphicon-pencil', 'pencil', 1),
(9, 'glyphicon glyphicon-glass', 'glass', 1),
(10, 'glyphicon glyphicon-music', 'music', 1),
(11, 'glyphicon glyphicon-search', 'search', 1),
(12, 'glyphicon glyphicon-heart', 'heart', 1),
(13, 'glyphicon glyphicon-star', 'star', 1),
(14, 'glyphicon glyphicon-star-empty', 'star-empty', 1),
(15, 'glyphicon glyphicon-user', 'user', 1),
(16, 'glyphicon glyphicon-film', 'film', 1),
(17, 'glyphicon glyphicon-th-large', '', 1),
(18, 'glyphicon glyphicon-th', '', 1),
(19, 'glyphicon glyphicon-th-list', '', 1),
(20, 'glyphicon glyphicon-ok', 'ok', 1),
(21, 'glyphicon glyphicon-remove', '', 1),
(22, 'glyphicon glyphicon-zoom-in', '', 1),
(23, 'glyphicon glyphicon-zoom-out', '', 1),
(24, 'glyphicon glyphicon-off', '', 1),
(25, 'glyphicon glyphicon-signal', 'signañ', 1),
(26, 'glyphicon glyphicon-cog', '', 1),
(27, 'glyphicon glyphicon-trash', '', 1),
(28, 'glyphicon glyphicon-home', '', 1),
(29, 'glyphicon glyphicon-file', '', 1),
(30, 'glyphicon glyphicon-time', '', 1),
(31, 'glyphicon glyphicon-road', '', 1),
(32, 'glyphicon glyphicon-download-alt', '', 1),
(33, 'glyphicon glyphicon-download', '', 1),
(34, 'glyphicon glyphicon-upload', '', 1),
(35, 'glyphicon glyphicon-inbox', '', 1),
(36, 'glyphicon glyphicon-play-circle', '', 1),
(37, 'glyphicon glyphicon-repeat', '', 1),
(38, 'glyphicon glyphicon-refresh', '', 1),
(39, 'glyphicon glyphicon-list-alt', '', 1),
(40, 'glyphicon glyphicon-lock', '', 1),
(41, 'glyphicon glyphicon-flag', '', 1),
(42, 'glyphicon glyphicon-headphones', '', 1),
(43, 'glyphicon glyphicon-volume-off', '', 1),
(44, 'glyphicon glyphicon-volume-down', '', 1),
(45, 'glyphicon glyphicon-volume-up', '', 1),
(46, 'glyphicon glyphicon-qrcode', '', 1),
(47, 'glyphicon glyphicon-barcode', '', 1),
(48, 'glyphicon glyphicon-tag', '', 1),
(49, 'glyphicon glyphicon-tags', '', 1),
(50, 'glyphicon glyphicon-book', '', 1),
(51, 'glyphicon glyphicon-bookmark', '', 1),
(52, 'glyphicon glyphicon-print', '', 1),
(53, 'glyphicon glyphicon-camera', '', 1),
(54, 'glyphicon glyphicon-font', '', 1),
(55, 'glyphicon glyphicon-bold', '', 1),
(56, 'glyphicon glyphicon-italic', '', 1),
(57, 'glyphicon glyphicon-text-height', '', 1),
(58, 'glyphicon glyphicon-text-width', '', 1),
(59, 'glyphicon glyphicon-align-left', '', 1),
(60, 'glyphicon glyphicon-align-center', '', 1),
(61, 'glyphicon glyphicon-align-right', '', 1),
(62, 'glyphicon glyphicon-align-justify', '', 1),
(63, 'glyphicon glyphicon-list', '', 1),
(64, 'glyphicon glyphicon-indent-left', '', 1),
(65, 'glyphicon glyphicon-indent-right', '', 1),
(66, 'glyphicon glyphicon-facetime-video', '', 1),
(67, 'glyphicon glyphicon-picture', '', 1),
(68, 'glyphicon glyphicon-map-marker', '', 1),
(69, 'glyphicon glyphicon-adjust', '', 1),
(70, 'glyphicon glyphicon-tint', '', 1),
(71, 'glyphicon glyphicon-edit', '', 1),
(72, 'glyphicon glyphicon-share', '', 1),
(73, 'glyphicon glyphicon-check', '', 1),
(74, 'glyphicon glyphicon-move', '', 1),
(75, 'glyphicon glyphicon-step-backward', '', 1),
(76, 'glyphicon glyphicon-fast-backward', '', 1),
(77, 'glyphicon glyphicon-backward', '', 1),
(78, 'glyphicon glyphicon-play', '', 1),
(79, 'glyphicon glyphicon-pause', '', 1),
(80, 'glyphicon glyphicon-stop', '', 1),
(81, 'glyphicon glyphicon-forward', '', 1),
(82, 'glyphicon glyphicon-fast-forward', '', 1),
(83, 'glyphicon glyphicon-step-forward', '', 1),
(84, 'glyphicon glyphicon-eject', '', 1),
(85, 'glyphicon glyphicon-chevron-left', '', 1),
(86, 'glyphicon glyphicon-chevron-right', '', 1),
(87, 'glyphicon glyphicon-plus-sign', '', 1),
(88, 'glyphicon glyphicon-minus-sign', '', 1),
(89, 'glyphicon glyphicon-remove-sign', '', 1),
(90, 'glyphicon glyphicon-ok-sign', '', 1),
(91, 'glyphicon glyphicon-question-sign', '', 1),
(92, 'glyphicon glyphicon-info-sign', '', 1),
(93, 'glyphicon glyphicon-screenshot', '', 1),
(94, 'glyphicon glyphicon-remove-circle', '', 1),
(95, 'glyphicon glyphicon-ok-circle', '', 1),
(96, 'glyphicon glyphicon-ban-circle', '', 1),
(97, 'glyphicon glyphicon-arrow-left', '', 1),
(98, 'glyphicon glyphicon-arrow-right', '', 1),
(99, 'glyphicon glyphicon-arrow-up', '', 1),
(100, 'glyphicon glyphicon-arrow-down', '', 1),
(101, 'glyphicon glyphicon-share-alt', '', 1),
(102, 'glyphicon glyphicon-resize-full', '', 1),
(103, 'glyphicon glyphicon-resize-small', '', 1),
(104, 'glyphicon glyphicon-exclamation-sign', '', 1),
(105, 'glyphicon glyphicon-gift', '', 1),
(106, 'glyphicon glyphicon-leaf', '', 1),
(107, 'glyphicon glyphicon-fire', '', 1),
(108, 'glyphicon glyphicon-eye-open', '', 1),
(109, 'glyphicon glyphicon-eye-close', '', 1),
(110, 'glyphicon glyphicon-warning-sign', '', 1),
(111, 'glyphicon glyphicon-plane', '', 1),
(112, 'glyphicon glyphicon-calendar', '', 1),
(113, 'glyphicon glyphicon-random', '', 1),
(114, 'glyphicon glyphicon-comment', '', 1),
(115, 'glyphicon glyphicon-magnet', '', 1),
(116, 'glyphicon glyphicon-chevron-up', '', 1),
(117, 'glyphicon glyphicon-chevron-down', '', 1),
(118, 'glyphicon glyphicon-retweet', '', 1),
(119, 'glyphicon glyphicon-shopping-cart', '', 1),
(120, 'glyphicon glyphicon-folder-close', '', 1),
(121, 'glyphicon glyphicon-folder-open', '', 1),
(122, 'glyphicon glyphicon-resize-vertical', '', 1),
(123, 'glyphicon glyphicon-resize-horizontal', '', 1),
(124, 'glyphicon glyphicon-hdd', '', 1),
(125, 'glyphicon glyphicon-bullhorn', '', 1),
(126, 'glyphicon glyphicon-bell', '', 1),
(127, 'glyphicon glyphicon-certificate', '', 1),
(128, 'glyphicon glyphicon-thumbs-up', '', 1),
(129, 'glyphicon glyphicon-thumbs-down', '', 1),
(130, 'glyphicon glyphicon-hand-right', '', 1),
(131, 'glyphicon glyphicon-hand-left', '', 1),
(132, 'glyphicon glyphicon-hand-up', '', 1),
(133, 'glyphicon glyphicon-hand-down', '', 1),
(134, 'glyphicon glyphicon-circle-arrow-right', '', 1),
(135, 'glyphicon glyphicon-circle-arrow-left', '', 1),
(136, 'glyphicon glyphicon-circle-arrow-up', '', 1),
(137, 'glyphicon glyphicon-circle-arrow-down', '', 1),
(138, 'glyphicon glyphicon-globe', '', 1),
(139, 'glyphicon glyphicon-wrench', '', 1),
(140, 'glyphicon glyphicon-tasks', '', 1),
(141, 'glyphicon glyphicon-filter', '', 1),
(142, 'glyphicon glyphicon-briefcase', '', 1),
(143, 'glyphicon glyphicon-fullscreen', '', 1),
(144, 'glyphicon glyphicon-dashboard', '', 1),
(145, 'glyphicon glyphicon-paperclip', '', 1),
(146, 'glyphicon glyphicon-heart-empty', '', 1),
(147, 'glyphicon glyphicon-link', '', 1),
(148, 'glyphicon glyphicon-phone', '', 1),
(149, 'glyphicon glyphicon-pushpin', '', 1),
(150, 'glyphicon glyphicon-usd', '', 1),
(151, 'glyphicon glyphicon-gbp', '', 1),
(152, 'glyphicon glyphicon-sort', '', 1),
(153, 'glyphicon glyphicon-sort-by-alphabet', '', 1),
(154, 'glyphicon glyphicon-sort-by-alphabet-alt', '', 1),
(155, 'glyphicon glyphicon-sort-by-order', '', 1),
(156, 'glyphicon glyphicon-sort-by-order-alt', '', 1),
(157, 'glyphicon glyphicon-sort-by-attributes', '', 1),
(158, 'glyphicon glyphicon-sort-by-attributes-alt', '', 1),
(159, 'glyphicon glyphicon-unchecked', '', 1),
(160, 'glyphicon glyphicon-expand', '', 1),
(161, 'glyphicon glyphicon-collapse-down', '', 1),
(162, 'glyphicon glyphicon-collapse-up', '', 1),
(163, 'glyphicon glyphicon-log-in', '', 1),
(164, 'glyphicon glyphicon-flash', '', 1),
(165, 'glyphicon glyphicon-log-out', '', 1),
(166, 'glyphicon glyphicon-new-window', '', 1),
(167, 'glyphicon glyphicon-record', '', 1),
(168, 'glyphicon glyphicon-save', '', 1),
(169, 'glyphicon glyphicon-open', '', 1),
(170, 'glyphicon glyphicon-saved', '', 1),
(171, 'glyphicon glyphicon-import', '', 1),
(172, 'glyphicon glyphicon-export', '', 1),
(173, 'glyphicon glyphicon-send', '', 1),
(174, 'glyphicon glyphicon-floppy-disk', '', 1),
(175, 'glyphicon glyphicon-floppy-saved', '', 1),
(176, 'glyphicon glyphicon-floppy-remove', '', 1),
(177, 'glyphicon glyphicon-floppy-save', '', 1),
(178, 'glyphicon glyphicon-floppy-open', '', 1),
(179, 'glyphicon glyphicon-credit-card', '', 1),
(180, 'glyphicon glyphicon-transfer', '', 1),
(181, 'glyphicon glyphicon-cutlery', 'cutlery', 1),
(182, 'glyphicon glyphicon-header', '', 1),
(183, 'glyphicon glyphicon-compressed', '', 1),
(184, 'glyphicon glyphicon-earphone', '', 1),
(185, 'glyphicon glyphicon-phone-alt', '', 1),
(186, 'glyphicon glyphicon-tower', '', 1),
(187, 'glyphicon glyphicon-stats', '', 1),
(188, 'glyphicon glyphicon-sd-video', '', 1),
(189, 'glyphicon glyphicon-hd-video', '', 1),
(190, 'glyphicon glyphicon-subtitles', '', 1),
(191, 'glyphicon glyphicon-sound-stereo', '', 1),
(192, 'glyphicon glyphicon-sound-dolby', '', 1),
(193, 'glyphicon glyphicon-sound-5-1', '', 1),
(194, 'glyphicon glyphicon-sound-6-1', '', 1),
(195, 'glyphicon glyphicon-sound-7-1', '', 1),
(196, 'glyphicon glyphicon-copyright-mark', '', 1),
(197, 'glyphicon glyphicon-registration-mark', '', 1),
(198, 'glyphicon glyphicon-cloud-download', '', 1),
(199, 'glyphicon glyphicon-cloud-upload', '', 1),
(200, 'glyphicon glyphicon-tree-conifer', '', 1),
(201, 'glyphicon glyphicon-tree-deciduous', '', 1),
(202, 'glyphicon glyphicon-cd', '', 1),
(203, 'glyphicon glyphicon-save-file', '', 1),
(204, 'glyphicon glyphicon-open-file', '', 1),
(205, 'glyphicon glyphicon-level-up', '', 1),
(206, 'glyphicon glyphicon-copy', '', 1),
(207, 'glyphicon glyphicon-paste', '', 1),
(208, 'glyphicon glyphicon-alert', '', 1),
(209, 'glyphicon glyphicon-equalizer', '', 1),
(210, 'glyphicon glyphicon-king', '', 1),
(211, 'glyphicon glyphicon-queen', '', 1),
(212, 'glyphicon glyphicon-pawn', '', 1),
(213, 'glyphicon glyphicon-bishop', '', 1),
(214, 'glyphicon glyphicon-knight', '', 1),
(215, 'glyphicon glyphicon-baby-formula', '', 1),
(216, 'glyphicon glyphicon-tent', '', 1),
(217, 'glyphicon glyphicon-blackboard', '', 1),
(218, 'glyphicon glyphicon-bed', '', 1),
(219, 'glyphicon glyphicon-apple', 'apple', 1),
(220, 'glyphicon glyphicon-erase', '', 1),
(221, 'glyphicon glyphicon-hourglass', '', 1),
(222, 'glyphicon glyphicon-lamp', '', 1),
(223, 'glyphicon glyphicon-duplicate', '', 1),
(224, 'glyphicon glyphicon-piggy-bank', '', 1),
(225, 'glyphicon glyphicon-scissors', '', 1),
(226, 'glyphicon glyphicon-bitcoin', '', 1),
(227, 'glyphicon glyphicon-btc', '', 1),
(228, 'glyphicon glyphicon-xbt', '', 1),
(229, 'glyphicon glyphicon-yen', '', 1),
(230, 'glyphicon glyphicon-jpy', '', 1),
(231, 'glyphicon glyphicon-ruble', '', 1),
(232, 'glyphicon glyphicon-rub', '', 1),
(233, 'glyphicon glyphicon-scale', '', 1),
(234, 'glyphicon glyphicon-ice-lolly', 'ice-lolly', 1),
(235, 'glyphicon glyphicon-ice-lolly-tasted', 'ice-lolly-tasted', 1),
(236, 'glyphicon glyphicon-education', '', 1),
(237, 'glyphicon glyphicon-option-horizontal', '', 1),
(238, 'glyphicon glyphicon-option-vertical', '', 1),
(239, 'glyphicon glyphicon-menu-hamburger', '', 1),
(240, 'glyphicon glyphicon-modal-window', '', 1),
(241, 'glyphicon glyphicon-oil', '', 1),
(242, 'glyphicon glyphicon-grain', 'grain', 1),
(243, 'glyphicon glyphicon-sunglasses', '', 1),
(244, 'glyphicon glyphicon-text-size', '', 1),
(245, 'glyphicon glyphicon-text-color', '', 1),
(246, 'glyphicon glyphicon-text-background', '', 1),
(247, 'glyphicon glyphicon-object-align-top', '', 1),
(248, 'glyphicon glyphicon-object-align-bottom', '', 1),
(249, 'glyphicon glyphicon-object-align-horizontal', '', 1),
(250, 'glyphicon glyphicon-object-align-left', '', 1),
(251, 'glyphicon glyphicon-object-align-vertical', '', 1),
(252, 'glyphicon glyphicon-object-align-right', '', 1),
(253, 'glyphicon glyphicon-triangle-right', '', 1),
(254, 'glyphicon glyphicon-triangle-left', '', 1),
(255, 'glyphicon glyphicon-triangle-bottom', '', 1),
(256, 'glyphicon glyphicon-triangle-top', '', 1),
(257, 'glyphicon glyphicon-console', '', 1),
(258, 'glyphicon glyphicon-superscript', '', 1),
(259, 'glyphicon glyphicon-subscript', '', 1),
(260, 'glyphicon glyphicon-menu-left', '', 1),
(261, 'glyphicon glyphicon-menu-right', '', 1),
(262, 'glyphicon glyphicon-menu-down', '', 1),
(263, 'glyphicon glyphicon-menu-up', '', 1),
(264, 'glyphicon glyphicon-user-key', 'user-key', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_interlocutor`
--

CREATE TABLE IF NOT EXISTS `fw_interlocutor` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=38 ;

--
-- Volcado de datos para la tabla `fw_interlocutor`
--

INSERT INTO `fw_interlocutor` (`id_interlocutor`, `interlocutor_id`, `nombre`, `apellido`, `interlocutor_clase_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `interlocutor_tipo_negocio_id`, `email`) VALUES
(0000000001, 0000000000, 'HERMAN ', 'TORRES', 1, 'cedula', '1089378345', 'calle 124', '3125657845', '3425671', 1, 0, '', 4, 'herman.torres@gmail.com'),
(0000000010, 0000000001, 'bar', 'bar', 2, 'cedula', '1111111111', 'calle 1', '1111111111', '111111111', 1, 1, 'bar test', 2, 'bar@gmail.com'),
(0000000011, 0000000001, 'restaurante', 'restaurante', 2, 'nit', '222222222', 'calle 22', '2222222222', '2222222', 1, 2, 'restaurante test', 3, 'restaurante@gmail.com'),
(0000000012, 0000000001, 'comercio', 'comercio', 2, 'nit', '333333333', 'calle 33', '3333333333', '33333333', 1, 3, 'comercio test', 1, 'comercio@gmail.com'),
(0000000013, 0000000010, 'Olivia', 'Velez', 3, 'cedula', '31497932', 'asdasdada', '12312312', '1231231', 1, 0, NULL, 0, 'asdasd@asd.com'),
(0000000014, 0000000001, 'Unplugged', 'bar', 2, 'cedula', '3342423', 'wdasdds', '2342342342', '2342342', 1, 1, 'Bar Unplugged', 2, 'herman.torres@wisgroup.com.co'),
(0000000015, 0000000001, 'Bajo', 'Fondo', 2, 'cedula', '12234', 'asdad', '1231231123', '1231231', 1, 2, 'Bar Bajo Fondo', 2, 'herman.torre@wisgroup.com.co'),
(0000000034, 0000000012, 'Yesica', 'Botero', 4, 'cedula', '1087548119', 'carrera', '3003321548', '3256487', 1, 0, '', 1, ''),
(0000000035, 0000000012, 'Alberto', 'proveedor', 3, 'nit', '45146141', 'calle', '3115879658', '3265848', 1, 0, '', 1, ''),
(0000000036, 0000000012, 'julian', 'proveedor', 3, 'cedula', '123123', '', '3776898', '3337657498', 1, 0, NULL, 0, 'hkd@kd.com'),
(0000000037, 0000000001, 'Santiago', 'Polo', 2, 'cedula', '11111111', 'xxxxxxx', '1111111111', '111111', 1, 1, 'Local Comercial', 1, 'polo-santiago@hotmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_interlocutor_clase`
--

CREATE TABLE IF NOT EXISTS `fw_interlocutor_clase` (
  `id_interlocutor_clase` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET latin1 NOT NULL,
  `estado_Id` int(11) NOT NULL DEFAULT '1',
  UNIQUE KEY `id_interlocutor_clase` (`id_interlocutor_clase`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `fw_interlocutor_clase`
--

INSERT INTO `fw_interlocutor_clase` (`id_interlocutor_clase`, `nombre`, `estado_Id`) VALUES
(1, 'administrador', 1),
(2, 'cliente WIS', 1),
(3, 'proveedor', 1),
(4, 'Cliente', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_interlocutor_condicion`
--

CREATE TABLE IF NOT EXISTS `fw_interlocutor_condicion` (
  `id_interlocutor_condicion` int(10) NOT NULL AUTO_INCREMENT,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL,
  `tema_id` int(8) NOT NULL DEFAULT '1',
  `titulo_sitio` varchar(25) NOT NULL DEFAULT '',
  `imagen_perfil` varchar(40) NOT NULL DEFAULT '',
  `imagen_logo` varchar(40) NOT NULL DEFAULT '',
  `marca_blanca` int(10) unsigned zerofill NOT NULL,
  `fuente_id` int(11) NOT NULL,
  PRIMARY KEY (`id_interlocutor_condicion`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `fw_interlocutor_condicion`
--

INSERT INTO `fw_interlocutor_condicion` (`id_interlocutor_condicion`, `interlocutor_id`, `tema_id`, `titulo_sitio`, `imagen_perfil`, `imagen_logo`, `marca_blanca`, `fuente_id`) VALUES
(1, 0000000001, 4, 'WIS:: FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000000, 1),
(5, 0000000010, 2, 'WIS::FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000010, 0),
(6, 0000000011, 3, 'WIS::FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000011, 0),
(7, 0000000012, 1, 'WIS::FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000012, 0),
(8, 0000000013, 1, 'WIS::FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000013, 0),
(9, 0000000014, 2, 'WIS::FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000014, 0),
(10, 0000000015, 2, 'WIS::FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000015, 0),
(13, 0000000000, 1, 'WIS::FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000000, 0),
(14, 0000000000, 1, 'WIS::FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000000, 0),
(15, 0000000037, 1, 'WIS::FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 0000000000, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_interlocutor_configuracion`
--

CREATE TABLE IF NOT EXISTS `fw_interlocutor_configuracion` (
  `id_interlocutor_configuracion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titulo_sitio` varchar(25) CHARACTER SET latin1 DEFAULT NULL,
  `imagen_perfil` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `imagen_logo` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `marca_blanca` int(11) DEFAULT NULL,
  `tema_id` int(10) unsigned DEFAULT NULL,
  `interlocutor_id` int(10) unsigned zerofill DEFAULT NULL,
  `default_option` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_interlocutor_configuracion`),
  UNIQUE KEY `UQ_interlocutor_configuracion_id_interlocutor_configuracion` (`id_interlocutor_configuracion`),
  KEY `interlocutor_id` (`interlocutor_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=42 ;

--
-- Volcado de datos para la tabla `fw_interlocutor_configuracion`
--

INSERT INTO `fw_interlocutor_configuracion` (`id_interlocutor_configuracion`, `titulo_sitio`, `imagen_perfil`, `imagen_logo`, `marca_blanca`, `tema_id`, `interlocutor_id`, `default_option`) VALUES
(1, 'WIS:: FRAMEWORK', '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, 1, 0000000001, 43),
(2, 'WIS:: FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 1, 3, 0000000002, 0),
(3, 'WIS:: FRAMEWORK', '14093288915400a6fbacff5.jpg', 'logo.png', 1, NULL, 0000000002, 0),
(4, NULL, '', '', 0, NULL, 0000000003, 0),
(5, NULL, '', '', 0, NULL, 0000000004, 0),
(6, NULL, '', '', 0, NULL, 0000000005, 0),
(7, NULL, '', '', 0, NULL, 0000000006, 0),
(8, NULL, '14093288915400a6fbacff5.jpg', 'logo.png', 1, NULL, 0000000007, 0),
(9, NULL, '14093288915400a6fbacff5.jpg', 'logo.png', 1, NULL, 0000000008, 0),
(10, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000009, 0),
(11, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000010, 0),
(12, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000011, 0),
(13, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000009, 0),
(14, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000010, 0),
(15, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000011, 0),
(16, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000012, 0),
(17, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000013, 0),
(18, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000014, 0),
(19, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000015, 0),
(31, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000027, 0),
(32, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000028, 0),
(33, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000029, 0),
(34, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000030, 0),
(35, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000031, 0),
(36, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000032, 0),
(37, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000033, 0),
(38, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000034, 0),
(39, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000035, 0),
(40, NULL, '14093288915400a6fbacff5.jpg', '0000000001.jpg', 1, NULL, 0000000036, 0),
(41, 'WIS:: FRAMEWORK', 'default.png', '0000000001.jpg', 1, 3, 0000000000, 43);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_interlocutor_marcablanca`
--

CREATE TABLE IF NOT EXISTS `fw_interlocutor_marcablanca` (
  `id_interlocutor_marcablanca` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tema_id` int(10) unsigned DEFAULT NULL,
  `titulo_sitio` varchar(25) CHARACTER SET latin1 DEFAULT NULL,
  `imagen_logo` varchar(60) CHARACTER SET latin1 DEFAULT NULL,
  `nombre_imagen_logo` varchar(60) CHARACTER SET latin1 DEFAULT NULL,
  `fuente_id` int(10) unsigned DEFAULT NULL,
  `interlocutor_id` int(11) NOT NULL,
  PRIMARY KEY (`id_interlocutor_marcablanca`),
  KEY `fuente_id` (`fuente_id`),
  KEY `tema_id` (`tema_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

--
-- Volcado de datos para la tabla `fw_interlocutor_marcablanca`
--

INSERT INTO `fw_interlocutor_marcablanca` (`id_interlocutor_marcablanca`, `tema_id`, `titulo_sitio`, `imagen_logo`, `nombre_imagen_logo`, `fuente_id`, `interlocutor_id`) VALUES
(1, 1, 'WIS:: FRAMEWORK', '145814345856e980e283708.jpg', 'foto-perfil facebook.jpg', 1, 1),
(2, 1, 'WIS:: FRAMEWORK', 'logo.png', 'logo.png', 2, 2),
(3, 1, 'WIS:: FRAMEWORK', 'logo.png', 'logo.png', 1, 0),
(8, 1, 'WIS:: FRAMEWORK', 'logo.png', 'logo.png', 1, 0),
(10, 1, 'WIS:: FRAMEWORK', 'logo.png', 'logo.png', 1, 0),
(11, 1, 'WIS:: FRAMEWORK', 'logo.png', 'logo.png', 1, 0),
(12, 1, 'WIS:: FRAMEWORK', 'logo.png', 'logo.png', 1, 0),
(19, 1, 'WIS:: FRAMEWORK', 'logo.png', 'logo.png', 1, 0),
(20, 1, 'WIS:: FRAMEWORK', 'logo.png', 'logo.png', 1, 0),
(21, 1, 'WIS:: FRAMEWORK', 'logo.png', 'logo.png', 1, 0),
(35, 2, 'WIS:: FRAMEWORK', 'logo.png', 'logo.png', 3, 0),
(36, 3, 'WIS:: FRAMEWORK', 'logo.png', 'logo.png', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_interlocutor_tipo_negocio`
--

CREATE TABLE IF NOT EXISTS `fw_interlocutor_tipo_negocio` (
  `id_interlocutor_tipo_negocio` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  `descripcion` varchar(300) CHARACTER SET latin1 NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '1',
  UNIQUE KEY `id_interlocutor_tipo_negocio` (`id_interlocutor_tipo_negocio`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `fw_interlocutor_tipo_negocio`
--

INSERT INTO `fw_interlocutor_tipo_negocio` (`id_interlocutor_tipo_negocio`, `nombre`, `descripcion`, `estado_id`) VALUES
(1, 'comercio', 'establecimientos de compra y venta directa de productos', 1),
(2, 'Bar', 'establecimiento de venta de licores', 1),
(3, 'restaurante', 'Establecimiento que ofrece servicios de alimentacion', 1),
(4, 'wis', 'wis', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_log`
--

CREATE TABLE IF NOT EXISTS `fw_log` (
  `id_log` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_log_id` tinyint(3) NOT NULL,
  `usuario_id` int(10) unsigned zerofill NOT NULL,
  `comentario` varchar(45) CHARACTER SET latin1 NOT NULL,
  `descripcion` varchar(500) CHARACTER SET latin1 NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(15) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=640 ;

--
-- Volcado de datos para la tabla `fw_log`
--

INSERT INTO `fw_log` (`id_log`, `tipo_log_id`, `usuario_id`, `comentario`, `descripcion`, `fecha`, `ip`) VALUES
(1, 2, 0000000000, 'comercio', '111111', '2016-05-19 08:38:37', '127.0.0.1'),
(2, 2, 0000000000, 'comercio1', '111111', '2016-05-19 08:38:48', '127.0.0.1'),
(3, 2, 0000000000, 'comercio1', '111111', '2016-05-19 08:39:03', '127.0.0.1'),
(4, 1, 0000000017, 'CASEL', '', '2016-05-19 08:40:13', '127.0.0.1'),
(5, 1, 0000000017, 'CASEL', '', '2016-05-19 11:07:02', '::1'),
(6, 1, 0000000017, 'CASEL', '', '2016-05-20 17:53:47', '127.0.0.1'),
(7, 1, 0000000017, 'CASEL', '', '2016-05-20 17:54:26', '127.0.0.1'),
(8, 1, 0000000001, 'appadmin', '', '2016-05-29 00:27:51', '127.0.0.1'),
(9, 1, 0000000017, 'casel', '', '2016-05-29 00:28:13', '127.0.0.1'),
(10, 1, 0000000001, 'appadmin', '', '2016-05-30 01:06:54', '::1'),
(11, 1, 0000000002, 'antoniorodriguez', '', '2016-05-30 01:08:11', '::1'),
(12, 1, 0000000002, 'antoniorodriguez', '', '2016-05-30 03:00:54', '::1'),
(13, 1, 0000000002, 'antoniorodriguez', '', '2016-05-30 03:04:06', '::1'),
(14, 1, 0000000002, 'antoniorodriguez', '', '2016-05-30 03:52:55', '::1'),
(15, 1, 0000000002, 'antoniorodriguez', '', '2016-05-30 04:11:34', '::1'),
(16, 1, 0000000002, 'antoniorodriguez', '', '2016-05-30 04:11:46', '::1'),
(17, 1, 0000000002, 'antoniorodriguez', '', '2016-05-30 04:12:03', '::1'),
(18, 1, 0000000002, 'antoniorodriguez', '', '2016-05-30 04:12:23', '::1'),
(19, 1, 0000000002, 'antoniorodriguez', '', '2016-05-30 04:12:41', '::1'),
(20, 1, 0000000002, 'antoniorodriguez', '', '2016-05-30 04:28:32', '::1'),
(21, 1, 0000000017, 'CASEL', '', '2016-05-30 04:37:26', '::1'),
(22, 1, 0000000002, 'antoniorodriguez', '', '2016-05-30 04:47:59', '::1'),
(23, 1, 0000000017, 'CASEL', '', '2016-05-30 05:54:22', '::1'),
(24, 1, 0000000017, 'casel', '', '2016-05-30 19:12:00', '::1'),
(25, 3, 0000000017, 'interlocutor', '`(`id_interlocutor`, `tipo_docuemnto`, `telefono`, `celular`, `direccion`, `observacion`) VALUES ( '''' ,  ''CC'' ,  ''31212'' ,  ''121'' ,  ''wsdsds'' ,  ''dsxs'' )', '2016-05-30 23:02:58', '::1'),
(26, 3, 0000000017, 'interlocutor', '`(`id_interlocutor`, `tipo_documento`, `telefono`, `celular`, `direccion`, `observacion`) VALUES ( '''' ,  ''CC'' ,  ''asas'' ,  ''asa'' ,  ''sas'' ,  ''ASSA'' )', '2016-05-30 23:03:48', '::1'),
(27, 3, 0000000017, 'interlocutor', '`(`id_interlocutor`, `tipo_documento`, `telefono`, `celular`, `direccion`) VALUES ( '''' ,  ''CC'' ,  ''312'' ,  ''036'' ,  ''direccion'' )', '2016-05-30 23:05:34', '::1'),
(28, 3, 0000000017, 'interlocutor', '`(`id_interlocutor`, `tipo_documento`, `nombre`, `apellido`, `telefono`, `celular`, `direccion`) VALUES ( '''' ,  ''cedula'' ,  ''Nombre'' ,  ''Apellido'' ,  ''311'' ,  ''033'' ,  ''direccion'' )', '2016-05-30 23:09:50', '::1'),
(29, 3, 0000000017, 'interlocutor', '`(`id_interlocutor`, `tipo_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''nombre'' ,  ''apellido'' ,  ''315'' ,  ''045'' ,  ''email'' ,  ''direccion'' ,  ''0000000004'' ,  ''4'' )', '2016-05-30 23:12:19', '::1'),
(30, 3, 0000000017, 'interlocutor', '`(`id_interlocutor`, `tipo_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''nit'' ,  ''sebasrian'' ,  ''florez'' ,  ''3128206036'' ,  ''03633789'' ,  ''sebasflorez10@gmail.com'' ,  ''asasasa'' ,  ''0000000004'' ,  ''4'' )', '2016-05-30 23:15:08', '::1'),
(31, 3, 0000000017, 'interlocutor', '`(`id_interlocutor`, `tipo_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''carlos'' ,  ''asas'' ,  ''sas'' ,  ''asa'' ,  ''sebas@c'' ,  ''as'' ,  ''0000000004'' ,  ''4'' )', '2016-05-30 23:16:41', '::1'),
(32, 3, 0000000017, 'interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''1090076711'' ,  ''Maria '' ,  ''Paul'' ,  ''389938'' ,  ''9431'' ,  ''qqwqw'' ,  ''qwqw'' ,  ''0000000004'' ,  ''4'' )', '2016-05-30 23:17:48', '::1'),
(33, 3, 0000000017, 'interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutore_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''asas'' ,  ''ASA'' ,  ''ASS'' ,  ''ASA'' ,  '''' ,  '''' ,  '''' ,  ''0000000004'' ,  ''4'' )', '2016-05-30 23:22:38', '::1'),
(34, 3, 0000000017, 'interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutDor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''33'' ,  ''323'' ,  ''Q33'' ,  '''' ,  '''' ,  '''' ,  '''' ,  ''0000000004'' ,  ''4'' )', '2016-05-30 23:24:07', '::1'),
(35, 3, 0000000017, 'interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''0004'' ,  ''Nueo '' ,  ''Proveedor'' ,  ''312'' ,  ''890'' ,  ''proveedor'' ,  ''pereira'' ,  ''0000000004'' ,  ''3'' )', '2016-05-31 01:40:52', '::1'),
(36, 1, 0000000005, 'mesero1', '', '2016-05-31 03:11:43', '::1'),
(37, 0, 0000000000, '', '', '2016-07-27 09:28:26', ''),
(38, 0, 0000000000, '', '', '2016-07-27 09:29:08', ''),
(39, 0, 0000000000, '', '', '2016-07-27 09:34:00', ''),
(40, 0, 0000000000, '', '', '2016-07-27 09:34:31', ''),
(41, 0, 0000000000, '', '', '2016-07-27 09:36:03', ''),
(42, 0, 0000000000, '', '', '2016-07-27 09:39:11', ''),
(43, 0, 0000000000, '', '', '2016-07-27 09:59:48', ''),
(44, 0, 0000000000, '', '', '2016-07-27 10:20:22', ''),
(45, 0, 0000000000, '', '', '2016-07-27 10:27:50', ''),
(46, 0, 0000000000, '', '', '2016-07-27 10:31:59', ''),
(47, 0, 0000000000, '', '', '2016-07-27 10:35:05', ''),
(48, 0, 0000000000, '', '', '2016-07-27 10:48:52', ''),
(49, 0, 0000000000, '', '', '2016-07-27 10:50:26', ''),
(50, 3, 0000000002, 'producto_categoria', '`(`nombre`, `estado_id`, `interlocutor_id`) VALUES ( ''Entradas'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:20:12', '::1'),
(51, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''Bebidas'' ,  ''2'' ,  ''Liquidos en el menú'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:36:42', '::1'),
(52, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''Asados'' ,  ''1'' ,  ''carnes y asados'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:38:08', '::1'),
(53, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''sopas'' ,  ''1'' ,  ''sopas y cositas'' ,  ''1'' ,  '''' )', '2016-08-01 08:39:23', '::1'),
(54, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''asdf'' ,  ''1'' ,  ''sdf'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:41:04', '::1'),
(55, 5, 0000000002, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=6', '2016-08-01 08:41:55', '::1'),
(56, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''rh'' ,  ''2'' ,  ''sdf'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:42:06', '::1'),
(57, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''hhh'' ,  ''2'' ,  ''hh'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:42:46', '::1'),
(58, 5, 0000000002, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=7 OR id_producto_categoria=8', '2016-08-01 08:43:15', '::1'),
(59, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''qw'' ,  ''1'' ,  ''sd'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:43:57', '::1'),
(60, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''rhetyr'' ,  ''1'' ,  ''safda'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:44:15', '::1'),
(61, 5, 0000000002, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=10', '2016-08-01 08:44:35', '::1'),
(62, 5, 0000000002, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=9', '2016-08-01 08:45:31', '::1'),
(63, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''tywre'' ,  ''1'' ,  ''wer'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:45:41', '::1'),
(64, 5, 0000000002, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=11', '2016-08-01 08:49:08', '::1'),
(65, 5, 0000000002, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=4', '2016-08-01 08:50:06', '::1'),
(66, 5, 0000000002, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=3', '2016-08-01 08:51:11', '::1'),
(67, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''adsf'' ,  ''1'' ,  ''af'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:51:19', '::1'),
(68, 5, 0000000002, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=12', '2016-08-01 08:52:31', '::1'),
(69, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''wer'' ,  ''1'' ,  ''afwr'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:52:38', '::1'),
(70, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `interlocutor_id`) VALUES ( ''sfg'' ,  ''1'' ,  ''qwrt'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:53:02', '::1'),
(71, 5, 0000000002, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=14', '2016-08-01 08:53:12', '::1'),
(72, 5, 0000000002, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=13', '2016-08-01 08:53:16', '::1'),
(73, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`) VALUES ( ''aver'' ,  ''1'' ,  ''aver'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 08:57:52', '::1'),
(74, 5, 0000000002, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=15', '2016-08-01 09:09:20', '::1'),
(75, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`) VALUES ( ''sopita'' ,  ''2'' ,  ''as'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 09:09:30', '::1'),
(76, 4, 0000000002, 'producto_categoria', '`id_producto_categoria` = ''16'', `nombre` = ''sopitas'', `orden` = ''2'', `descripcion` = ''assssss'', `estado_id` = ''1'', `usuario_id` = ''2'' WHERE id_producto_categoria = ''16''', '2016-08-01 09:21:52', '::1'),
(77, 4, 0000000002, 'producto_categoria', '`id_producto_categoria` = ''16'', `nombre` = ''sopitas'', `orden` = ''2'', `descripcion` = ''assssss'', `estado_id` = ''1'', `usuario_id` = ''2'' WHERE id_producto_categoria = ''16''', '2016-08-01 09:23:00', '::1'),
(78, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`) VALUES ( ''Jugos'' ,  ''0'' ,  ''juguitos'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 19:52:54', '::1'),
(79, 5, 0000000002, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=16', '2016-08-01 19:54:34', '::1'),
(80, 4, 0000000002, 'producto_categoria', '`id_producto_categoria` = ''2'', `nombre` = ''Entradas'', `orden` = ''0'', `descripcion` = ''asdfasd'', `estado_id` = ''1'', `usuario_id` = ''2'' WHERE id_producto_categoria = ''2''', '2016-08-01 19:54:46', '::1'),
(81, 4, 0000000002, 'producto_categoria', '`id_producto_categoria` = ''2'', `nombre` = ''Entradas'', `orden` = ''0'', `descripcion` = ''asdfasdsdf'', `estado_id` = ''1'', `usuario_id` = ''2'' WHERE id_producto_categoria = ''2''', '2016-08-01 19:57:22', '::1'),
(82, 4, 0000000002, 'producto_categoria', '`id_producto_categoria` = ''17'', `nombre` = ''Jugos'', `orden` = ''0'', `descripcion` = ''juguitos frios'', `estado_id` = ''1'', `usuario_id` = ''2'' WHERE id_producto_categoria = ''17''', '2016-08-01 19:58:29', '::1'),
(83, 4, 0000000002, 'producto_categoria', '`id_producto_categoria` = ''2'', `nombre` = ''Entradas'', `orden` = ''0'', `descripcion` = ''aaaaaaaaa'', `estado_id` = ''1'', `usuario_id` = ''2'' WHERE id_producto_categoria = ''2''', '2016-08-01 20:00:06', '::1'),
(84, 4, 0000000002, 'producto_categoria', '`id_producto_categoria` = ''2'', `nombre` = ''Entradas'', `orden` = ''2'', `descripcion` = ''aaaaaaaaa'', `estado_id` = ''1'', `usuario_id` = ''2'' WHERE id_producto_categoria = ''2''', '2016-08-01 20:00:33', '::1'),
(85, 4, 0000000002, 'producto_categoria', '`id_producto_categoria` = ''17'', `nombre` = ''Jugos'', `orden` = ''0'', `descripcion` = ''juguitos frios'', `estado_id` = ''2'', `usuario_id` = ''2'' WHERE id_producto_categoria = ''17''', '2016-08-01 20:00:47', '::1'),
(86, 4, 0000000002, 'producto_categoria', '`id_producto_categoria` = ''17'', `nombre` = ''Jugos'', `orden` = ''0'', `descripcion` = ''juguitos frios'', `estado_id` = ''1'', `usuario_id` = ''2'' WHERE id_producto_categoria = ''17''', '2016-08-01 20:00:59', '::1'),
(87, 3, 0000000002, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `interlocutor_id`) VALUES ( '''' ,  ''gaseosa'' ,  ''manzana'' ,  ''E5R1'' ,  ''17'' ,  ''16'' ,  ''2000'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 20:24:40', '::1'),
(88, 3, 0000000002, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `interlocutor_id`) VALUES ( '''' ,  ''crema de pollo'' ,  ''cremi poio'' ,  ''G2A2'' ,  ''5'' ,  ''16'' ,  ''3500'' ,  ''1'' ,  ''0000000002'' )', '2016-08-01 20:27:13', '::1'),
(89, 4, 0000000002, 'producto', '`id_producto` = ''6993'', `nombre` = ''gaseosa'', `nombre_corto` = ''manzanas'', `referencia` = ''E5R1'', `producto_categoria_id` = ''17'', `iva` = ''16'', `precio` = ''2000'', `estado_id` = ''1'', `interlocutor_id` = ''0000000002'' WHERE id_producto = ''6993''', '2016-08-02 00:56:32', '::1'),
(90, 4, 0000000002, 'producto', '`id_producto` = ''6993'', `nombre` = ''gaseosa'', `nombre_corto` = ''manzana'', `referencia` = ''E5R1'', `producto_categoria_id` = ''17'', `iva` = ''16'', `precio` = ''2000'', `estado_id` = ''1'', `interlocutor_id` = ''0000000002'' WHERE id_producto = ''6993''', '2016-08-02 00:57:17', '::1'),
(91, 4, 0000000002, 'producto', '`id_producto` = ''6993'', `nombre` = ''gaseosa'', `nombre_corto` = ''manzana'', `referencia` = ''E5R1'', `producto_categoria_id` = ''17'', `iva` = ''16'', `precio` = ''2000'', `estado_id` = ''1'', `interlocutor_id` = ''0000000002'' WHERE id_producto = ''6993''', '2016-08-02 01:05:10', '::1'),
(92, 4, 0000000002, 'producto', '`id_producto` = ''6993'', `nombre` = ''gaseosa'', `nombre_corto` = ''manzana'', `referencia` = ''E5R1'', `producto_categoria_id` = ''17'', `iva` = ''16'', `precio` = ''2000'', `estado_id` = ''1'', `interlocutor_id` = ''0000000002'' WHERE id_producto = ''6993''', '2016-08-02 01:06:01', '::1'),
(93, 4, 0000000002, 'producto', '`id_producto` = ''6993'', `nombre` = ''gaseosa'', `nombre_corto` = ''manzana'', `referencia` = ''E5R1'', `producto_categoria_id` = ''17'', `iva` = ''16'', `precio` = ''2000'', `estado_id` = ''1'', `interlocutor_id` = ''0000000002'' WHERE id_producto = ''6993''', '2016-08-02 01:09:24', '::1'),
(94, 4, 0000000002, 'producto', '`id_producto` = ''6993'', `nombre` = ''gaseosa'', `nombre_corto` = ''manzana'', `referencia` = ''E5R1'', `producto_categoria_id` = ''17'', `iva` = ''16'', `precio` = ''2000'', `estado_id` = ''1'', `interlocutor_id` = ''0000000002'' WHERE id_producto = ''6993''', '2016-08-02 01:12:13', '::1'),
(95, 4, 0000000002, 'producto', '`id_producto` = ''6993'', `nombre` = ''gaseosa'', `nombre_corto` = ''manzana'', `referencia` = ''E5R1'', `producto_categoria_id` = ''17'', `iva` = ''16'', `precio` = ''2000'', `estado_id` = ''1'', `interlocutor_id` = ''0000000002'' WHERE id_producto = ''6993''', '2016-08-02 01:12:39', '::1'),
(96, 4, 0000000002, 'producto_categoria', '`id_producto_categoria` = ''17'', `nombre` = ''Jugos'', `orden` = ''0'', `descripcion` = ''juguitos frios'', `estado_id` = ''1'', `usuario_id` = ''2'' WHERE id_producto_categoria = ''17''', '2016-08-02 01:12:49', '::1'),
(97, 4, 0000000002, 'producto', '`id_producto` = ''6993'', `nombre` = ''gaseosas'', `nombre_corto` = ''manzanas'', `referencia` = ''E5R1S'', `producto_categoria_id` = ''2'', `iva` = ''16'', `precio` = ''20000'', `estado_id` = ''1'', `interlocutor_id` = ''0000000002'' WHERE id_producto = ''6993''', '2016-08-02 01:14:36', '::1'),
(98, 4, 0000000002, 'producto', '`id_producto` = ''6993'', `nombre` = ''gaseosas'', `nombre_corto` = ''manzanas'', `referencia` = ''E5R1S'', `producto_categoria_id` = ''17'', `iva` = ''16'', `precio` = ''2000'', `estado_id` = ''1'', `interlocutor_id` = ''0000000002'' WHERE id_producto = ''6993''', '2016-08-02 01:14:48', '::1'),
(99, 4, 0000000002, 'producto', '`id_producto` = ''6993'', `nombre` = ''gaseosas'', `nombre_corto` = ''manzanas'', `referencia` = ''E5R1S'', `producto_categoria_id` = ''17'', `iva` = ''16'', `precio` = ''2000'', `estado_id` = ''1'', `descripcion` = ''gaseosinhas'', `interlocutor_id` = ''0000000002'' WHERE id_producto = ''6993''', '2016-08-02 01:28:25', '::1'),
(100, 1, 0000000001, 'appadmin', '', '2016-08-02 02:07:24', '::1'),
(101, 1, 0000000001, 'appadmin', '', '2016-08-02 02:17:47', '::1'),
(102, 1, 0000000001, 'appadmin', '', '2016-08-02 03:45:49', '::1'),
(103, 1, 0000000001, 'appadmin', '', '2016-08-02 03:53:08', '::1'),
(104, 1, 0000000002, 'bar1', '', '2016-08-02 23:38:51', '::1'),
(105, 1, 0000000001, 'appadmin', '', '2016-08-02 23:39:11', '::1'),
(106, 1, 0000000001, 'appadmin', '', '2016-08-02 23:41:38', '::1'),
(107, 1, 0000000002, 'bar1', '', '2016-08-03 00:10:36', '::1'),
(108, 1, 0000000001, 'appadmin', '', '2016-08-03 00:13:58', '::1'),
(109, 1, 0000000002, 'bar1', '', '2016-08-03 00:15:05', '::1'),
(110, 1, 0000000001, 'appadmin', '', '2016-08-03 00:38:40', '::1'),
(111, 1, 0000000001, 'appadmin', '', '2016-08-03 03:35:22', '::1'),
(112, 1, 0000000002, 'bar1', '', '2016-08-03 03:37:02', '::1'),
(113, 1, 0000000001, 'appadmin', '', '2016-08-03 03:51:16', '::1'),
(114, 1, 0000000001, 'appadmin', '', '2016-08-03 04:05:01', '::1'),
(115, 1, 0000000002, 'bar1', '', '2016-08-03 04:22:12', '::1'),
(116, 2, 0000000000, 'msero1', '111111', '2016-08-03 04:29:33', '::1'),
(117, 1, 0000000002, 'bar1', '', '2016-08-03 04:31:43', '::1'),
(118, 1, 0000000001, 'appadmin', '', '2016-08-03 04:54:44', '::1'),
(119, 1, 0000000001, 'appadmin', '', '2016-08-03 05:02:51', '::1'),
(120, 1, 0000000001, 'appadmin', '', '2016-08-03 05:03:24', '::1'),
(121, 1, 0000000001, 'appadmin', '', '2016-08-03 05:07:57', '::1'),
(122, 1, 0000000002, 'bar1', '', '2016-08-03 05:19:27', '::1'),
(123, 1, 0000000001, 'appadmin', '', '2016-08-03 08:26:29', '::1'),
(124, 1, 0000000001, 'appadmin', '', '2016-08-03 08:30:01', '::1'),
(125, 1, 0000000001, 'appadmin', '', '2016-08-03 20:14:56', '::1'),
(126, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''Wilson'' ,  ''Pinto'' ,  ''3'' ,  ''2'' ,  ''cedula'' ,  ''1088293298'' ,  ''calle 123'' ,  ''321444111'' ,  ''3425672'' ,  ''1'' ,  ''2'' ,  ''negocio de pizza'' ,  ''wdp@gmail.com'' )', '2016-08-03 20:22:48', '::1'),
(127, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''Wilson'' ,  ''Pinto'' ,  ''3'' ,  ''2'' ,  ''cedula'' ,  ''1088293298'' ,  ''calle 123'' ,  ''321444111'' ,  ''3425672'' ,  ''1'' ,  ''2'' ,  ''negocio de pizza'' ,  ''wdp@gmail.com'' )', '2016-08-03 20:45:04', '::1'),
(128, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''Wilson'' ,  ''Pinto'' ,  ''3'' ,  ''2'' ,  ''cedula'' ,  ''1088293298'' ,  ''calle 123'' ,  ''321444111'' ,  ''3425672'' ,  ''1'' ,  ''2'' ,  ''negocio de pizza'' ,  ''wdp@gmail.com'' )', '2016-08-03 20:46:28', '::1'),
(129, 1, 0000000002, 'bar1', '', '2016-08-03 23:06:25', '::1'),
(130, 1, 0000000001, 'appadmin', '', '2016-08-05 18:49:24', '::1'),
(131, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nickname`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''migue'' ,  ''ang'' ,  ''pinto'' ,  ''3'' ,  ''2'' ,  ''cedula'' ,  ''1234564345'' ,  ''calle 34'' ,  ''3234456789'' ,  ''2345674'' ,  ''1'' ,  ''1'' ,  ''sdasd'' ,  ''a@a'' )', '2016-08-05 19:00:31', '::1'),
(132, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''ang'' ,  ''pinto'' ,  ''3'' ,  ''2'' ,  ''cedula'' ,  ''1234567896'' ,  ''calle12'' ,  ''356789786'' ,  ''34567897'' ,  ''1'' ,  ''1'' ,  ''asd'' ,  ''a@a'' )', '2016-08-05 19:03:53', '::1'),
(133, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''asd'' ,  ''asd'' ,  ''1'' ,  ''2'' ,  ''cedula'' ,  ''1231342452342'' ,  ''axca'' ,  ''14234234132'' ,  ''2342343123'' ,  ''1'' ,  ''1'' ,  ''asdgt'' ,  ''a@a'' )', '2016-08-05 19:09:38', '::1'),
(134, 3, 0000000001, 'producto_categoria', '`(`usuario_id`) VALUES ( ''0000000001'' )', '2016-08-05 19:15:59', '::1'),
(135, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''ads'' ,  ''asd'' ,  ''1'' ,  ''2'' ,  ''cedula'' ,  ''1234565434'' ,  ''fadsf'' ,  ''2345678909'' ,  ''45678985'' ,  ''1'' ,  ''2'' ,  ''asd'' ,  ''a@a'' )', '2016-08-05 19:17:23', '::1'),
(136, 3, 0000000001, 'producto_categoria', '`(`usuario_id`) VALUES ( ''0000000001'' )', '2016-08-05 19:28:51', '::1'),
(137, 1, 0000000002, 'bar1', '', '2016-08-05 19:29:13', '::1'),
(138, 3, 0000000002, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`) VALUES ( ''carne'' ,  ''1'' ,  ''afaf'' ,  ''1'' ,  ''0000000002'' )', '2016-08-05 19:29:34', '::1'),
(139, 1, 0000000001, 'appadmin', '', '2016-08-08 23:45:48', '::1'),
(140, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''qwe'' ,  ''asda'' ,  ''1'' ,  ''2'' ,  ''cedula'' ,  ''231353412312'' ,  ''xfad'' ,  ''123123134223'' ,  ''123123123'' ,  ''1'' ,  ''1'' ,  ''sadasd'' ,  ''as@a'' )', '2016-08-08 23:46:28', '::1'),
(141, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''ert'' ,  ''ret'' ,  ''1'' ,  ''2'' ,  ''cedula'' ,  ''23424534523'' ,  ''sdfdf'' ,  ''13231231214'' ,  ''123123123123'' ,  ''1'' ,  ''1'' ,  ''dfsfhjy'' ,  ''a@g'' )', '2016-08-08 23:49:33', '::1'),
(142, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''angel'' ,  ''pinto'' ,  ''1'' ,  ''2'' ,  ''cedula'' ,  ''1099867584'' ,  ''calle12 n 80-12'' ,  ''34256786789'' ,  ''3456567'' ,  ''1'' ,  ''1'' ,  ''hijo'' ,  ''migue@gmail.com'' )', '2016-08-09 00:26:58', '::1'),
(143, 2, 0000000000, 'migue', '111111', '2016-08-09 00:36:59', '::1'),
(144, 2, 0000000000, 'migue', '111111', '2016-08-09 00:37:10', '::1'),
(145, 1, 0000000005, 'miguel', '', '2016-08-09 00:37:35', '::1'),
(146, 1, 0000000001, 'appadmin', '', '2016-08-09 00:49:29', '::1'),
(147, 1, 0000000001, 'appadmin', '', '2016-08-09 00:55:45', '::1'),
(148, 1, 0000000001, 'appadmin', '', '2016-08-09 00:59:15', '::1'),
(149, 1, 0000000001, 'appadmin', '', '2016-08-09 01:08:11', '::1'),
(150, 1, 0000000001, 'appadmin', '', '2016-08-09 01:34:47', '::1'),
(151, 1, 0000000001, 'appadmin', '', '2016-08-09 01:47:29', '::1'),
(152, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `interlocutor_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''bar'' ,  ''bar'' ,  ''2'' ,  ''2'' ,  ''0000000001'' ,  ''nit'' ,  ''1111111111'' ,  ''calle 1'' ,  ''1111111111'' ,  ''111111111'' ,  ''1'' ,  ''1'' ,  ''bar test'' ,  ''bar@gmail.com'' )', '2016-08-09 01:59:08', '::1'),
(153, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `interlocutor_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''restaurante'' ,  ''restaurante'' ,  ''3'' ,  ''2'' ,  ''0000000001'' ,  ''nit'' ,  ''222222222'' ,  ''calle 22'' ,  ''2222222222'' ,  ''2222222'' ,  ''1'' ,  ''2'' ,  ''restaurante test'' ,  ''restaurante@gmail.com'' )', '2016-08-09 02:19:00', '::1'),
(154, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `interlocutor_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''comercio'' ,  ''comercio'' ,  ''1'' ,  ''2'' ,  ''0000000001'' ,  ''nit'' ,  ''333333333'' ,  ''calle 33'' ,  ''3333333333'' ,  ''33333333'' ,  ''1'' ,  ''3'' ,  ''comercio test'' ,  ''comercio@gmail.com'' )', '2016-08-09 02:25:19', '::1'),
(155, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `interlocutor_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''qwe'' ,  ''qwe'' ,  ''1'' ,  ''2'' ,  ''0000000001'' ,  ''cedula'' ,  ''123123123123'' ,  ''13qwe'' ,  ''123123123'' ,  ''12312312312'' ,  ''1'' ,  ''1'' ,  ''123123'' ,  ''1@gm'' )', '2016-08-09 02:34:27', '::1'),
(156, 5, 0000000001, 'fw_interlocutor', '`estado_id` = ''3'' WHERE  id_interlocutor=0000000013', '2016-08-09 02:34:53', '::1'),
(157, 1, 0000000001, 'appadmin', '', '2016-08-09 02:55:01', '::1'),
(158, 4, 0000000001, 'fw_interlocutor', '`id_interlocutor` = ''0000000010'', `nombre` = ''bar'', `apellido` = ''bar1'', `interlocutor_tipo_negocio_id` = ''2'', `interlocutor_clase_id` = ''2'', `interlocutor_id` = ''0000000001'', `tipo_documento` = ''cedula'', `num_documento` = ''1111111111'', `direccion` = ''calle 1'', `celular` = ''1111111111'', `telefono` = ''111111111'', `estado_id` = ''1'', `orden` = ''1'', `descripcion` = ''bar test'', `email` = ''bar@gmail.com'' WHERE id_interlocutor = ''0000000010''', '2016-08-09 03:13:55', '::1'),
(159, 4, 0000000001, 'fw_interlocutor', '`id_interlocutor` = ''0000000010'', `nombre` = ''bar'', `apellido` = ''bar'', `interlocutor_tipo_negocio_id` = ''2'', `interlocutor_clase_id` = ''2'', `interlocutor_id` = ''0000000001'', `tipo_documento` = ''cedula'', `num_documento` = ''1111111111'', `direccion` = ''calle 1'', `celular` = ''1111111111'', `telefono` = ''111111111'', `estado_id` = ''1'', `orden` = ''1'', `descripcion` = ''bar test'', `email` = ''bar@gmail.com'' WHERE id_interlocutor = ''0000000010''', '2016-08-09 03:14:16', '::1'),
(160, 1, 0000000006, 'bar', '', '2016-08-09 03:51:56', '::1'),
(161, 1, 0000000007, 'restaurante', '', '2016-08-09 03:59:44', '::1'),
(162, 1, 0000000008, 'comercio', '', '2016-08-09 04:01:36', '::1'),
(163, 1, 0000000006, 'bar', '', '2016-08-09 06:01:41', '::1'),
(164, 1, 0000000001, 'appadmin', '', '2016-08-09 06:01:57', '::1'),
(165, 1, 0000000001, 'appadmin', '', '2016-08-09 07:21:36', '::1'),
(166, 1, 0000000001, 'appadmin', '', '2016-08-09 07:22:05', '::1'),
(167, 1, 0000000006, 'bar', '', '2016-08-09 07:38:37', '::1'),
(168, 1, 0000000006, 'bar', '', '2016-08-09 07:40:50', '::1'),
(169, 1, 0000000006, 'bar', '', '2016-08-09 08:03:32', '::1'),
(170, 3, 0000000006, 'fw_usuario', '`(`id_usuario`, `interlocutor_id`, `usuario_perfil_id`, `nickname`, `nombre`, `apellido`, `num_documento`, `email`, `estado_id`, `clave`) VALUES ( '''' ,  ''0000000010'' ,  ''2'' ,  ''mesabar'' ,  ''mesero'' ,  ''mesero'' ,  ''10987887656'' ,  ''mesero@gmail.com'' ,  ''1'' ,  ''337cee421b526aaf0cb4ec2f7beec50eb8da2129'' )', '2016-08-09 08:10:40', '::1'),
(171, 1, 0000000008, 'comercio', '', '2016-08-09 08:16:53', '::1'),
(172, 1, 0000000006, 'bar', '', '2016-08-09 08:17:12', '::1'),
(173, 1, 0000000007, 'restaurante', '', '2016-08-09 08:17:30', '::1'),
(174, 1, 0000000007, 'restaurante', '', '2016-08-09 08:18:43', '::1'),
(175, 1, 0000000007, 'restaurante', '', '2016-08-09 08:20:42', '::1'),
(176, 3, 0000000007, 'fw_usuario', '`(`id_usuario`, `interlocutor_id`, `usuario_perfil_id`, `nickname`, `nombre`, `apellido`, `num_documento`, `email`, `estado_id`, `clave`) VALUES ( '''' ,  ''0000000011'' ,  ''2'' ,  ''mesarestaurante'' ,  ''mesero'' ,  ''mesero'' ,  ''19898767890'' ,  ''mesa@gmail.com'' ,  ''1'' ,  ''337cee421b526aaf0cb4ec2f7beec50eb8da2129'' )', '2016-08-09 08:21:39', '::1'),
(177, 1, 0000000010, 'mesabar', '', '2016-08-09 08:23:10', '::1'),
(178, 1, 0000000011, 'mesarestaurante', '', '2016-08-09 08:23:30', '::1'),
(179, 1, 0000000006, 'bar', '', '2016-08-09 08:29:32', '::1'),
(180, 1, 0000000010, 'mesabar', '', '2016-08-09 08:39:09', '::1'),
(181, 2, 0000000000, 'meserorestaurante', '111111', '2016-08-09 08:40:45', '::1'),
(182, 1, 0000000011, 'mesarestaurante', '', '2016-08-09 08:40:57', '::1'),
(183, 1, 0000000006, 'bar', '', '2016-08-09 08:43:28', '::1'),
(184, 2, 0000000000, 'barmesa', '111111', '2016-08-09 08:44:55', '::1'),
(185, 1, 0000000010, 'mesabar', '', '2016-08-09 08:45:06', '::1'),
(186, 1, 0000000006, 'bar', '', '2016-08-09 22:03:10', '::1'),
(187, 1, 0000000001, 'appadmin', '', '2016-08-09 22:03:40', '::1'),
(188, 1, 0000000001, 'appadmin', '', '2016-08-09 22:19:33', '::1'),
(189, 1, 0000000006, 'bar', '', '2016-08-09 22:27:00', '::1'),
(190, 1, 0000000006, 'bar', '', '2016-08-09 22:57:18', '::1'),
(191, 1, 0000000010, 'mesabar', '', '2016-08-10 00:53:32', '::1'),
(192, 1, 0000000010, 'mesabar', '', '2016-08-10 00:56:18', '::1'),
(193, 1, 0000000006, 'bar', '', '2016-08-10 01:03:13', '::1'),
(194, 1, 0000000008, 'comercio', '', '2016-08-10 02:01:55', '::1'),
(195, 3, 0000000008, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`) VALUES ( ''gorras'' ,  ''1'' ,  ''todas las gorras'' ,  ''1'' ,  ''0000000008'' )', '2016-08-10 07:15:51', '::1'),
(196, 3, 0000000008, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`, `marca_blanca`) VALUES ( ''gorras'' ,  ''1'' ,  ''todas las gorras'' ,  ''1'' ,  ''0000000008'' ,  ''0000000012'' )', '2016-08-10 07:21:08', '::1'),
(197, 3, 0000000008, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`, `marca_blanca`) VALUES ( ''gorras'' ,  ''1'' ,  ''todas las gorras'' ,  ''1'' ,  ''0000000008'' ,  ''0000000012'' )', '2016-08-10 07:28:56', '::1'),
(198, 3, 0000000008, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`, `marca_blanca`) VALUES ( ''asd'' ,  ''1'' ,  ''asdqwe'' ,  ''1'' ,  ''0000000008'' ,  ''0000000012'' )', '2016-08-10 07:31:32', '::1'),
(199, 3, 0000000008, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`, `marca_blanca`) VALUES ( ''gorras'' ,  ''1'' ,  ''todas las gorras'' ,  ''1'' ,  ''0000000008'' ,  ''0000000012'' )', '2016-08-10 07:32:21', '::1'),
(200, 3, 0000000008, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`, `marca_blanca`) VALUES ( ''camisas'' ,  ''2'' ,  ''camisetas'' ,  ''1'' ,  ''0000000008'' ,  ''0000000012'' )', '2016-08-10 07:40:15', '::1'),
(201, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`, `stock`, `unidad_medida_id`, `estante`) VALUES ( '''' ,  ''gorra verde'' ,  ''Fox verde'' ,  ''IA123A'' ,  ''25'' ,  ''16'' ,  ''30000'' ,  ''1'' ,  ''gorra verde a lo bien'' ,  ''0000000012'' ,  ''13'' ,  ''1'' ,  ''13'' )', '2016-08-10 07:46:37', '::1'),
(202, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`, `stock`, `unidad_medida_id`, `estante`) VALUES ( '''' ,  ''gorra fox verde'' ,  ''Fox verde'' ,  ''IA2F4'' ,  ''25'' ,  ''16'' ,  ''20000'' ,  ''1'' ,  ''gorrita visaje'' ,  ''0000000012'' ,  ''16'' ,  ''1'' ,  ''186'' )', '2016-08-10 07:48:57', '::1'),
(203, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''gorra verde'' ,  ''Fox verde'' ,  ''IA2G4'' ,  ''25'' ,  ''16'' ,  ''20000'' ,  ''1'' ,  ''gorrita visaje'' ,  ''0000000012'' )', '2016-08-10 07:50:02', '::1'),
(204, 4, 0000000008, 'producto', '`id_producto` = ''6995'', `nombre` = ''gorra verde'', `nombre_corto` = ''Fox verde'', `referencia` = ''IA2G4'', `producto_categoria_id` = ''25'', `iva` = ''16'', `precio` = ''20000'', `estado_id` = ''1'', `descripcion` = ''gorrita visaje si ñor'', `interlocutor_id` = ''0000000012'' WHERE id_producto = ''6995''', '2016-08-10 07:50:52', '::1'),
(205, 4, 0000000008, 'producto', '`id_producto` = ''6995'', `nombre` = ''gorra verde'', `nombre_corto` = ''Fox verde'', `referencia` = ''IA2G4'', `producto_categoria_id` = ''25'', `iva` = ''16'', `precio` = ''20000'', `estado_id` = ''1'', `descripcion` = ''gorrita visaje si ñor'', `interlocutor_id` = ''0000000012'' WHERE id_producto = ''6995''', '2016-08-10 08:01:34', '::1'),
(206, 4, 0000000008, 'producto', '`id_producto` = ''6995'', `nombre` = ''gorra verde'', `nombre_corto` = ''Fox verde'', `referencia` = ''IA2G4'', `producto_categoria_id` = ''25'', `iva` = ''16'', `precio` = ''20000'', `estado_id` = ''1'', `descripcion` = ''gorrita visaje si ñor'', `interlocutor_id` = ''0000000012'' WHERE id_producto = ''6995''', '2016-08-10 08:12:31', '::1'),
(207, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''qdsd'' ,  ''qwe'' ,  ''1qwe'' ,  ''25'' ,  ''16'' ,  ''12312'' ,  ''1'' ,  ''sda'' ,  ''0000000012'' )', '2016-08-10 08:42:20', '::1'),
(208, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''asd'' ,  ''asd'' ,  ''qwedsa'' ,  ''25'' ,  ''16'' ,  ''124'' ,  ''1'' ,  ''qdqsa'' ,  ''0000000012'' )', '2016-08-10 08:44:23', '::1'),
(209, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''ewrwr'' ,  ''wer'' ,  ''sdf'' ,  ''25'' ,  ''16'' ,  ''123'' ,  ''1'' ,  ''sd'' ,  ''0000000012'' )', '2016-08-10 08:45:41', '::1'),
(210, 1, 0000000006, 'bar', '', '2016-08-10 21:22:03', '::1'),
(211, 1, 0000000008, 'comercio', '', '2016-08-10 21:22:24', '::1'),
(212, 4, 0000000008, 'producto', '`id_producto` = ''6995'', `nombre` = ''gorra verde'', `nombre_corto` = ''Fox verde'', `referencia` = ''IA2G4'', `producto_categoria_id` = ''25'', `iva` = ''16'', `precio` = ''20000'', `estado_id` = ''1'', `descripcion` = ''gorrita visaje si ñor'', `interlocutor_id` = ''0000000012'' WHERE id_producto = ''6995''', '2016-08-10 21:46:40', '::1'),
(213, 4, 0000000008, 'producto', '`id_producto` = ''6995'', `nombre` = ''gorra verde'', `nombre_corto` = ''Fox verde'', `referencia` = ''IA2G4'', `producto_categoria_id` = ''25'', `iva` = ''16'', `precio` = ''20000'', `estado_id` = ''1'', `descripcion` = ''gorrita visaje si ñor'', `interlocutor_id` = ''0000000012'' WHERE id_producto = ''6995''', '2016-08-10 21:48:10', '::1'),
(214, 4, 0000000008, 'producto', '`id_producto` = ''6995'', `nombre` = ''gorra verde'', `nombre_corto` = ''Fox verde'', `referencia` = ''IA2G4'', `producto_categoria_id` = ''25'', `iva` = ''16'', `precio` = ''20000'', `estado_id` = ''1'', `descripcion` = ''gorrita visaje si ñor'', `interlocutor_id` = ''0000000012'' WHERE id_producto = ''6995''', '2016-08-10 21:49:34', '::1'),
(215, 4, 0000000008, 'producto', '`id_producto` = ''6995'', `nombre` = ''gorra verde'', `nombre_corto` = ''Fox verde'', `referencia` = ''IA2G4'', `producto_categoria_id` = ''25'', `iva` = ''16'', `precio` = ''20000'', `estado_id` = ''1'', `descripcion` = ''gorrita visaje si ñor'', `interlocutor_id` = ''0000000012'' WHERE id_producto = ''6995''', '2016-08-10 21:51:00', '::1'),
(216, 4, 0000000008, 'producto', '`id_producto` = ''6995'', `nombre` = ''gorra verde'', `nombre_corto` = ''Fox verde'', `referencia` = ''IA2G4'', `producto_categoria_id` = ''25'', `iva` = ''16'', `precio` = ''20000'', `estado_id` = ''1'', `descripcion` = ''gorrita visaje si ñor'', `interlocutor_id` = ''0000000012'' WHERE id_producto = ''6995''', '2016-08-10 21:54:17', '::1'),
(217, 4, 0000000008, 'producto', '`id_producto` = ''6995'', `nombre` = ''gorra verde'', `nombre_corto` = ''Fox verde'', `referencia` = ''IA2G4'', `producto_categoria_id` = ''25'', `iva` = ''16'', `precio` = ''20000'', `estado_id` = ''1'', `descripcion` = ''gorrita visaje si ñor'', `interlocutor_id` = ''0000000012'' WHERE id_producto = ''6995''', '2016-08-10 21:56:29', '::1'),
(218, 4, 0000000008, 'producto', '`id_producto` = ''6995'', `nombre` = ''Gorra'', `nombre_corto` = ''Fox Roja'', `referencia` = ''IA2G45'', `producto_categoria_id` = ''25'', `iva` = ''16'', `precio` = ''50000'', `estado_id` = ''1'', `descripcion` = ''gorrita visaje si ñores'', `interlocutor_id` = ''0000000012'' WHERE id_producto = ''6995''', '2016-08-10 21:57:03', '::1'),
(219, 5, 0000000008, 'producto', '`estado_id` = ''3'' WHERE  id_producto=6998', '2016-08-10 22:10:35', '::1'),
(220, 1, 0000000008, 'comercio', '', '2016-08-10 23:25:40', '::1'),
(221, 3, 0000000008, 'observacion', '`(`nombre`, `orden`, `estado_id`, `interlocutor_id`) VALUES ( ''sin cebolla'' ,  ''1'' ,  ''1'' ,  ''0000000012'' )', '2016-08-11 01:39:12', '::1'),
(222, 3, 0000000008, 'observacion', '`(`nombre`, `orden`, `estado_id`, `interlocutor_id`) VALUES ( ''sin ripio'' ,  ''0'' ,  ''1'' ,  ''0000000012'' )', '2016-08-11 01:39:59', '::1'),
(223, 4, 0000000008, 'observacion', '`id_observacion` = ''72'', `nombre` = ''sin cebollas'', `orden` = ''1'', `estado_id` = ''1'' WHERE id_observacion = ''72''', '2016-08-11 01:40:54', '::1'),
(224, 2, 0000000000, 'appadmin', '222222', '2016-08-11 01:46:38', '::1'),
(225, 1, 0000000001, 'appadmin', '', '2016-08-11 01:46:46', '::1'),
(226, 1, 0000000008, 'comercio', '', '2016-08-11 01:48:33', '::1'),
(227, 1, 0000000001, 'appadmin', '', '2016-08-11 01:49:26', '::1'),
(228, 1, 0000000007, 'restaurante', '', '2016-08-11 01:50:02', '::1'),
(229, 3, 0000000007, 'observacion', '`(`nombre`, `orden`, `estado_id`, `interlocutor_id`) VALUES ( ''sin hielo'' ,  ''1'' ,  ''1'' ,  ''0000000011'' )', '2016-08-11 01:56:39', '::1'),
(230, 4, 0000000007, 'observacion', '`id_observacion` = ''74'', `nombre` = ''sin hielos'', `orden` = ''1'', `estado_id` = ''1'' WHERE id_observacion = ''74''', '2016-08-11 02:06:45', '::1'),
(231, 3, 0000000007, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''1'' ,  ''mesa 1'' ,  ''11'' ,  ''0'' ,  '''' ,  ''0000000011'' )', '2016-08-11 02:07:14', '::1'),
(232, 3, 0000000007, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''2'' ,  ''mesa 2'' ,  ''11'' ,  ''1'' ,  '''' ,  ''0000000011'' )', '2016-08-11 02:08:22', '::1'),
(233, 3, 0000000007, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''3'' ,  ''mesa 3'' ,  ''11'' ,  ''3'' ,  '''' ,  ''0000000011'' )', '2016-08-11 02:09:11', '::1'),
(234, 3, 0000000007, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''4'' ,  ''mesa 4'' ,  ''11'' ,  ''4'' ,  '''' ,  ''0000000011'' )', '2016-08-11 02:10:45', '::1'),
(235, 4, 0000000007, 'mesa', '`id_mesa` = ''116'', `nombre` = ''3'', `descripcion` = ''mesa 3'', `estado_id` = ''11'', `orden` = ''2'', `mesero_id` = ''0'' WHERE id_mesa = ''116''', '2016-08-11 02:11:03', '::1'),
(236, 4, 0000000007, 'mesa', '`id_mesa` = ''117'', `nombre` = ''4'', `descripcion` = ''mesa 4'', `estado_id` = ''11'', `orden` = ''3'', `mesero_id` = ''0'' WHERE id_mesa = ''117''', '2016-08-11 02:11:11', '::1'),
(237, 1, 0000000001, 'appadmin', '', '2016-08-11 02:40:25', '::1'),
(238, 1, 0000000006, 'bar', '', '2016-08-11 02:40:54', '::1'),
(239, 1, 0000000001, 'appadmin', '', '2016-08-11 02:41:14', '::1'),
(240, 1, 0000000007, 'restaurante', '', '2016-08-11 02:41:41', '::1'),
(241, 1, 0000000006, 'bar', '', '2016-08-11 02:42:00', '::1'),
(242, 1, 0000000007, 'restaurante', '', '2016-08-11 02:42:56', '::1'),
(243, 3, 0000000007, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`, `marca_blanca`) VALUES ( ''jugos'' ,  ''1'' ,  ''todos los jugos'' ,  ''1'' ,  ''0000000007'' ,  ''0000000011'' )', '2016-08-11 02:49:35', '::1'),
(244, 3, 0000000007, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''mango'' ,  ''mango'' ,  ''IA12'' ,  ''27'' ,  ''16'' ,  ''3000'' ,  ''1'' ,  ''jugo de mango bien aleta'' ,  ''0000000011'' )', '2016-08-11 02:53:32', '::1'),
(245, 1, 0000000007, 'restaurante', '', '2016-08-12 00:34:41', '::1'),
(246, 3, 0000000007, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''manzana'' ,  ''gaseosa'' ,  ''asdqw'' ,  ''27'' ,  ''16'' ,  ''1000'' ,  ''1'' ,  ''awsasd'' ,  ''0000000011'' )', '2016-08-12 03:56:45', '::1'),
(247, 1, 0000000007, 'restaurante', '', '2016-08-12 20:50:29', '::1'),
(248, 3, 0000000007, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`, `marca_blanca`) VALUES ( ''asados'' ,  ''2'' ,  ''disfrute de nuestros mejores cortes de carne de res, cerdo o pollo asados al carbon'' ,  ''1'' ,  ''0000000007'' ,  ''0000000011'' )', '2016-08-12 21:58:24', '::1'),
(249, 4, 0000000007, 'producto_categoria', '`id_producto_categoria` = ''28'', `nombre` = ''carnes asadas'', `orden` = ''2'', `descripcion` = ''disfrute de nuestros mejores cortes de carne de res, cerdo o pollo asados al carbon'', `estado_id` = ''1'', `usuario_id` = ''0000000007'', `marca_blanca` = ''0000000011'' WHERE id_producto_categoria = ''28''', '2016-08-12 22:04:11', '::1'),
(250, 5, 0000000007, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=28', '2016-08-12 22:09:48', '::1'),
(251, 1, 0000000007, 'restaurante', '', '2016-08-12 23:48:50', '::1'),
(252, 4, 0000000007, 'producto', '`id_producto` = ''6999'', `nombre` = ''mango'', `nombre_corto` = ''mango'', `referencia` = ''IA12'', `producto_categoria_id` = ''27'', `iva` = ''16'', `precio` = ''3000'', `estado_id` = ''1'', `descripcion` = ''jugo de mango bien aleta'', `interlocutor_id` = ''0000000011'' WHERE id_producto = ''6999''', '2016-08-13 00:01:42', '::1'),
(253, 1, 0000000007, 'restaurante', '', '2016-08-13 00:03:38', '::1'),
(254, 1, 0000000007, 'restaurante', '', '2016-08-13 00:04:58', '::1'),
(255, 4, 0000000007, 'producto', '`id_producto` = ''6999'', `nombre` = ''mango'', `nombre_corto` = ''mango'', `referencia` = ''IA12'', `producto_categoria_id` = ''27'', `iva` = ''16'', `precio` = ''3500'', `estado_id` = ''1'', `descripcion` = ''jugo de mango bien frio'', `interlocutor_id` = ''0000000011'' WHERE id_producto = ''6999''', '2016-08-13 00:08:58', '::1'),
(256, 5, 0000000007, 'producto', '`estado_id` = ''3'' WHERE  id_producto=6999', '2016-08-13 00:11:54', '::1'),
(257, 4, 0000000007, 'producto', '`id_producto` = ''6999'', `nombre` = ''mango'', `nombre_corto` = ''mango'', `referencia` = ''IA12'', `producto_categoria_id` = ''27'', `iva` = ''16'', `precio` = ''3500'', `estado_id` = ''1'', `descripcion` = ''jugo de mango bien frio'', `interlocutor_id` = ''0000000011'' WHERE id_producto = ''6999''', '2016-08-13 00:17:08', '::1'),
(258, 4, 0000000007, 'producto', '`id_producto` = ''6999'', `nombre` = ''mango'', `nombre_corto` = ''mango'', `referencia` = ''IA12'', `producto_categoria_id` = ''27'', `iva` = ''16'', `precio` = ''3500'', `estado_id` = ''1'', `descripcion` = ''jugo de mango bien frio'', `interlocutor_id` = ''0000000011'' WHERE id_producto = ''6999''', '2016-08-13 00:19:41', '::1'),
(259, 4, 0000000007, 'mesa', '`id_mesa` = ''114'', `nombre` = ''VIP'', `descripcion` = ''mesa 1'', `estado_id` = ''12'', `orden` = ''0'', `mesero_id` = ''0'' WHERE id_mesa = ''114''', '2016-08-13 00:26:31', '::1'),
(260, 4, 0000000007, 'mesa', '`id_mesa` = ''114'', `nombre` = ''VIP'', `descripcion` = ''mesa 1'', `estado_id` = ''12'', `orden` = ''7'', `mesero_id` = ''0'' WHERE id_mesa = ''114''', '2016-08-13 00:26:55', '::1'),
(261, 4, 0000000007, 'producto', '`id_producto` = ''7000'', `nombre` = ''manzana'', `nombre_corto` = ''gaseosa'', `referencia` = ''asdqw'', `producto_categoria_id` = ''27'', `iva` = ''16'', `precio` = ''1000'', `estado_id` = ''1'', `descripcion` = ''awsasd'', `interlocutor_id` = ''0000000011'' WHERE id_producto = ''7000''', '2016-08-13 00:49:21', '::1'),
(262, 4, 0000000007, 'producto', '`id_producto` = ''7000'', `nombre` = ''manzana'', `nombre_corto` = ''gaseosa'', `referencia` = ''asdqw'', `producto_categoria_id` = ''27'', `iva` = ''16'', `precio` = ''1000'', `estado_id` = ''1'', `descripcion` = ''awsasd'', `interlocutor_id` = ''0000000011'' WHERE id_producto = ''7000''', '2016-08-13 00:49:25', '::1'),
(263, 3, 0000000007, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''punta de anca'' ,  ''punta de anca'' ,  ''AI23'' ,  ''28'' ,  ''16'' ,  ''15000'' ,  ''1'' ,  ''delicioso corte de punta de anca con tiempo de asado a preferencia de nuestros clientes'' ,  ''0000000011'' )', '2016-08-13 00:51:06', '::1'),
(264, 3, 0000000007, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''punta de anca'' ,  ''punta de anca'' ,  ''AI23'' ,  ''28'' ,  ''16'' ,  ''15000'' ,  ''1'' ,  ''delicioso corte de punta de anca con tiempo de asado a preferencia de nuestros clientes'' ,  ''0000000011'' )', '2016-08-13 01:28:16', '::1'),
(265, 1, 0000000007, 'restaurante', '', '2016-08-13 04:35:01', '::1'),
(266, 5, 0000000007, 'producto', '`estado_id` = ''3'' WHERE  id_producto=7002', '2016-08-13 05:07:40', '::1'),
(267, 1, 0000000007, 'restaurante', '', '2016-08-13 20:44:19', '::1'),
(268, 3, 0000000007, 'observacion', '`(`nombre`, `orden`, `estado_id`, `interlocutor_id`) VALUES ( ''asado 3/4'' ,  ''1'' ,  ''1'' ,  ''0000000011'' )', '2016-08-13 21:10:48', '::1'),
(269, 1, 0000000006, 'bar', '', '2016-08-13 22:05:46', '::1'),
(270, 1, 0000000001, 'appadmin', '', '2016-08-13 22:06:08', '::1'),
(271, 1, 0000000006, 'bar', '', '2016-08-13 22:07:40', '::1'),
(272, 1, 0000000006, 'bar', '', '2016-08-13 22:13:15', '::1'),
(273, 1, 0000000006, 'bar', '', '2016-08-13 22:14:15', '::1'),
(274, 1, 0000000006, 'bar', '', '2016-08-13 22:14:55', '::1'),
(275, 1, 0000000010, 'mesabar', '', '2016-08-13 22:15:39', '::1'),
(276, 1, 0000000007, 'restaurante', '', '2016-08-13 22:16:11', '::1'),
(277, 1, 0000000006, 'bar', '', '2016-08-13 22:23:22', '::1'),
(278, 1, 0000000001, 'appadmin', '', '2016-08-13 22:27:10', '::1'),
(279, 1, 0000000001, 'appadmin', '', '2016-08-13 22:28:41', '::1'),
(280, 1, 0000000001, 'appadmin', '', '2016-08-13 22:29:51', '::1'),
(281, 1, 0000000001, 'appadmin', '', '2016-08-13 22:31:09', '::1'),
(282, 1, 0000000001, 'appadmin', '', '2016-08-13 22:32:43', '::1'),
(283, 1, 0000000001, 'appadmin', '', '2016-08-13 22:33:44', '::1'),
(284, 1, 0000000001, 'appadmin', '', '2016-08-13 22:34:24', '::1'),
(285, 1, 0000000006, 'bar', '', '2016-08-13 22:39:21', '::1'),
(286, 1, 0000000010, 'mesabar', '', '2016-08-13 22:42:09', '::1'),
(287, 1, 0000000001, 'appadmin', '', '2016-08-16 19:51:09', '::1'),
(288, 1, 0000000006, 'bar', '', '2016-08-16 19:51:33', '::1'),
(289, 3, 0000000006, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''1'' ,  ''1'' ,  ''11'' ,  ''1'' ,  '''' ,  ''0000000010'' )', '2016-08-16 19:54:23', '::1');
INSERT INTO `fw_log` (`id_log`, `tipo_log_id`, `usuario_id`, `comentario`, `descripcion`, `fecha`, `ip`) VALUES
(290, 3, 0000000006, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''2'' ,  ''2'' ,  ''11'' ,  ''2'' ,  '''' ,  ''0000000010'' )', '2016-08-16 19:55:12', '::1'),
(291, 3, 0000000006, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''3'' ,  ''3'' ,  ''11'' ,  ''3'' ,  '''' ,  ''0000000010'' )', '2016-08-16 19:55:19', '::1'),
(292, 3, 0000000006, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''4'' ,  ''4'' ,  ''11'' ,  ''4'' ,  '''' ,  ''0000000010'' )', '2016-08-16 19:55:26', '::1'),
(293, 1, 0000000010, 'mesabar', '', '2016-08-16 19:58:02', '::1'),
(294, 1, 0000000006, 'bar', '', '2016-08-16 19:58:26', '::1'),
(295, 1, 0000000010, 'mesabar', '', '2016-08-16 19:59:10', '::1'),
(296, 1, 0000000006, 'bar', '', '2016-08-16 19:59:30', '::1'),
(297, 3, 0000000006, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `estado_id`, `usuario_id`, `marca_blanca`) VALUES ( ''jugos'' ,  ''1'' ,  ''juguitos'' ,  ''1'' ,  ''0000000006'' ,  ''0000000010'' )', '2016-08-16 20:04:15', '::1'),
(298, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''jugo de mango'' ,  ''mango'' ,  ''aq12'' ,  ''29'' ,  ''16'' ,  ''2500'' ,  ''1'' ,  '''' ,  ''0000000010'' )', '2016-08-16 20:04:57', '::1'),
(299, 3, 0000000006, 'observacion', '`(`nombre`, `orden`, `estado_id`, `interlocutor_id`) VALUES ( ''sin hielo'' ,  ''1'' ,  ''1'' ,  ''0000000010'' )', '2016-08-16 20:26:11', '::1'),
(300, 1, 0000000008, 'comercio', '', '2016-08-16 22:32:43', '::1'),
(301, 1, 0000000001, 'appadmin', '', '2016-08-16 22:32:53', '::1'),
(302, 1, 0000000008, 'comercio', '', '2016-08-16 22:33:39', '::1'),
(303, 3, 0000000008, 'fw_usuario', '`(`id_usuario`, `interlocutor_id`, `usuario_perfil_id`, `nickname`, `nombre`, `apellido`, `num_documento`, `email`, `estado_id`, `password`, `clave`) VALUES ( '''' ,  ''0000000012'' ,  ''1'' ,  ''wdpinto'' ,  ''wdpinto'' ,  ''pinto'' ,  ''108966832'' ,  ''daniel.p_2407@hotmail.com'' ,  ''1'' ,  ''wdpinto'' ,  ''d749591bd3c16abe08fb63914011d088d64f3020'' )', '2016-08-16 22:40:26', '::1'),
(304, 3, 0000000008, 'fw_usuario', '`(`id_usuario`, `interlocutor_id`, `usuario_perfil_id`, `nickname`, `nombre`, `apellido`, `num_documento`, `email`, `estado_id`, `clave`) VALUES ( '''' ,  ''0000000012'' ,  ''1'' ,  ''wdpinto'' ,  ''wilson'' ,  ''pinto'' ,  ''1088293892'' ,  ''daniel.p_2407@hotmail.com'' ,  ''1'' ,  ''d749591bd3c16abe08fb63914011d088d64f3020'' )', '2016-08-16 22:41:51', '::1'),
(305, 1, 0000000012, 'wdpinto', '', '2016-08-16 22:42:04', '::1'),
(306, 1, 0000000006, 'bar', '', '2016-08-16 22:52:01', '::1'),
(307, 1, 0000000006, 'bar', '', '2016-08-16 23:55:15', '::1'),
(308, 1, 0000000006, 'bar', '', '2016-08-17 20:43:51', '::1'),
(309, 3, 0000000006, 'observacion', '`(`nombre`, `orden`, `estado_id`, `interlocutor_id`) VALUES ( ''sin azucar'' ,  ''2'' ,  ''1'' ,  ''0000000010'' )', '2016-08-17 21:06:02', '::1'),
(310, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''producto'' ,  ''producto'' ,  ''IAS21'' ,  ''29'' ,  ''16'' ,  ''2000'' ,  ''1'' ,  '''' ,  ''0000000010'' )', '2016-08-17 21:18:23', '::1'),
(311, 4, 0000000006, 'producto', '`id_producto` = ''7004'', `nombre` = ''producto'', `nombre_corto` = ''producto'', `referencia` = ''IAS21'', `producto_categoria_id` = ''29'', `iva` = ''16'', `precio` = ''2000'', `estado_id` = ''1'', `descripcion` = '''', `interlocutor_id` = ''0000000010'' WHERE id_producto = ''7004''', '2016-08-17 22:26:48', '::1'),
(312, 1, 0000000008, 'comercio', '', '2016-08-17 23:07:01', '::1'),
(313, 1, 0000000010, 'mesabar', '', '2016-08-17 23:07:28', '::1'),
(314, 1, 0000000007, 'restaurante', '', '2016-08-17 23:07:59', '::1'),
(315, 1, 0000000001, 'appadmin', '', '2016-08-17 23:08:24', '::1'),
(316, 1, 0000000007, 'restaurante', '', '2016-08-17 23:10:21', '::1'),
(317, 1, 0000000006, 'bar', '', '2016-08-17 23:17:54', '::1'),
(318, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `estado_id`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''prueba'' ,  ''prueba'' ,  ''qasw23'' ,  ''29'' ,  ''16'' ,  ''16000'' ,  ''1'' ,  '''' ,  ''0000000010'' )', '2016-08-17 23:53:08', '::1'),
(319, 1, 0000000001, 'appadmin', '', '2016-08-18 01:24:59', '::1'),
(320, 1, 0000000007, 'restaurante', '', '2016-08-18 01:27:19', '::1'),
(321, 1, 0000000006, 'bar', '', '2016-08-18 01:33:50', '::1'),
(322, 1, 0000000007, 'restaurante', '', '2016-08-18 01:35:09', '::1'),
(323, 1, 0000000006, 'bar', '', '2016-08-18 01:49:14', '::1'),
(324, 3, 0000000006, 'mesa', '`(`nombre`, `descripcion`, `estado_id`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''mesa'' ,  ''mesa'' ,  ''11'' ,  ''1'' ,  '''' ,  ''0000000010'' )', '2016-08-18 02:26:12', '::1'),
(325, 2, 0000000000, 'bar', '11111', '2016-08-19 01:08:27', '::1'),
(326, 1, 0000000006, 'bar', '', '2016-08-19 01:08:48', '::1'),
(327, 1, 0000000006, 'bar', '', '2016-08-19 02:11:30', '::1'),
(328, 4, 0000000006, 'producto', '`id_producto` = ''7003'', `nombre` = ''jugo de mango'', `nombre_corto` = ''mango'', `referencia` = '''', `producto_categoria_id` = ''29'', `iva` = ''16'', `precio` = ''2500'', `estado_id` = ''1'', `descripcion` = '''', `interlocutor_id` = ''0000000010'' WHERE id_producto = ''7003''', '2016-08-19 02:23:02', '::1'),
(329, 1, 0000000006, 'bar', '', '2016-08-19 11:10:34', '::1'),
(330, 1, 0000000006, 'bar', '', '2016-08-19 11:41:16', '::1'),
(331, 3, 0000000006, 'fw_usuario', '`(`id_usuario`, `interlocutor_id`, `usuario_perfil_id`, `nickname`, `nombre`, `apellido`, `num_documento`, `email`, `estado_id`, `clave`) VALUES ( '''' ,  ''0000000010'' ,  ''1'' ,  ''wdaniel'' ,  ''daniel'' ,  ''pinto'' ,  ''102938472'' ,  ''daniel@hotmail.co'' ,  ''1'' ,  ''beaa5dfd32a64a9298926ccb8fbe416556975432'' )', '2016-08-19 11:42:34', '::1'),
(332, 4, 0000000006, 'fw_usuario', '`id_usuario` = ''0000000013'', `interlocutor_id` = ''0000000010'', `usuario_perfil_id` = ''1'', `nickname` = ''wdaniel'', `nombre` = ''daniel'', `apellido` = ''pinto'', `num_documento` = ''102938472'', `email` = ''daniel@hotmail.co'', `estado_id` = ''2'', `clave` = ''beaa5dfd32a64a9298926ccb8fbe416556975432'' WHERE id_usuario = ''0000000013''', '2016-08-19 11:42:45', '::1'),
(333, 1, 0000000006, 'bar', '', '2016-08-20 00:17:43', '::1'),
(334, 4, 0000000006, 'producto_categoria', '`id_producto_categoria` = ''29'', `nombre` = ''jugos'', `orden` = ''1'', `descripcion` = ''juguitos'', `usuario_id` = ''0000000006'', `marca_blanca` = ''0000000010'' WHERE id_producto_categoria = ''29''', '2016-08-20 00:48:47', '::1'),
(335, 4, 0000000006, 'producto_categoria', '`id_producto_categoria` = ''29'', `nombre` = ''jugos'', `orden` = ''1'', `descripcion` = ''juguitos'', `usuario_id` = ''0000000006'', `marca_blanca` = ''0000000010'' WHERE id_producto_categoria = ''29''', '2016-08-20 00:57:04', '::1'),
(336, 4, 0000000006, 'producto_categoria', '`id_producto_categoria` = ''29'', `nombre` = ''jugos'', `orden` = ''1'', `descripcion` = ''juguitos'', `usuario_id` = ''0000000006'', `marca_blanca` = ''0000000010'' WHERE id_producto_categoria = ''29''', '2016-08-20 01:05:32', '::1'),
(337, 3, 0000000006, 'mesa', '`(`nombre`, `descripcion`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''mesa 3'' ,  ''mesa buena'' ,  ''0'' ,  '''' ,  ''0000000010'' )', '2016-08-20 01:06:14', '::1'),
(338, 4, 0000000006, 'mesa', '`id_mesa` = ''123'', `nombre` = ''mesa'', `descripcion` = ''mesa buena'', `orden` = ''1'', `mesero_id` = ''0'' WHERE id_mesa = ''123''', '2016-08-20 01:06:34', '::1'),
(339, 5, 0000000006, 'mesa', '`estado_id` = ''3'' WHERE  id_mesa=123', '2016-08-20 01:06:47', '::1'),
(340, 1, 0000000008, 'comercio', '', '2016-08-20 01:35:45', '201.236.221.26'),
(341, 1, 0000000006, 'bar', '', '2016-08-20 02:41:11', '201.236.221.26'),
(342, 1, 0000000006, 'bar', '', '2016-08-20 04:38:09', '186.81.131.169'),
(343, 1, 0000000001, 'appadmin', '', '2016-08-20 04:41:54', '186.81.131.169'),
(344, 1, 0000000006, 'bar', '', '2016-08-20 04:44:12', '186.81.131.169'),
(345, 1, 0000000006, 'bar', '', '2016-08-20 05:06:36', '186.86.33.195'),
(346, 1, 0000000006, 'bar', '', '2016-08-20 05:28:34', '181.71.27.92'),
(347, 1, 0000000006, 'bar', '', '2016-08-20 07:27:57', '181.71.27.92'),
(348, 1, 0000000008, 'comercio', '', '2016-08-20 08:41:42', '186.86.33.195'),
(349, 1, 0000000006, 'bar', '', '2016-08-23 00:52:09', '181.135.80.11'),
(350, 1, 0000000008, 'comercio', '', '2016-08-23 00:54:30', '181.135.80.11'),
(351, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''cag'' ,  ''cag'' ,  ''cag'' ,  ''25'' ,  ''16'' ,  ''5000'' ,  '''' ,  ''0000000012'' )', '2016-08-23 00:55:19', '181.135.80.11'),
(352, 1, 0000000006, 'bar', '', '2016-08-30 05:59:23', '181.135.80.11'),
(353, 1, 0000000001, 'appadmin', '', '2016-09-01 01:04:47', '186.81.131.169'),
(354, 1, 0000000006, 'bar', '', '2016-09-01 01:05:25', '186.81.131.169'),
(355, 1, 0000000006, 'bar', '', '2016-09-01 07:08:53', '::1'),
(356, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Producto test'' ,  ''PT'' ,  ''PPTT'' ,  ''29'' ,  ''16'' ,  ''1000'' ,  ''asdasda'' ,  ''0000000010'' )', '2016-09-01 10:21:23', '::1'),
(357, 3, 0000000006, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''31497932'' ,  ''Olivia'' ,  ''Velez'' ,  ''1231231'' ,  ''12312312'' ,  ''asdasd@asd.com'' ,  ''asdasdada'' ,  ''0000000010'' ,  ''3'' )', '2016-09-01 10:24:41', '::1'),
(358, 1, 0000000001, 'appadmin', '', '2016-09-01 18:41:12', '::1'),
(359, 1, 0000000006, 'bar', '', '2016-09-01 18:41:43', '::1'),
(360, 1, 0000000006, 'bar', '', '2016-09-02 00:03:52', '::1'),
(361, 3, 0000000006, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Cervezas'' ,  ''2'' ,  ''Cervezas'' ,  ''0000000006'' ,  ''0000000010'' )', '2016-09-02 07:11:29', '::1'),
(362, 3, 0000000006, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Crepes'' ,  ''3'' ,  ''Crepes'' ,  ''0000000006'' ,  ''0000000010'' )', '2016-09-02 07:14:22', '::1'),
(363, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Poker'' ,  ''Poker'' ,  ''CVZ001'' ,  ''30'' ,  ''16'' ,  ''3000'' ,  ''Cerveza Poker'' ,  ''0000000010'' )', '2016-09-02 07:15:24', '::1'),
(364, 1, 0000000006, 'bar', '', '2016-09-03 03:18:07', '::1'),
(365, 4, 0000000006, 'producto', '`id_producto` = ''7003'', `nombre` = ''jugo de mango'', `nombre_corto` = ''mango'', `referencia` = '''', `producto_categoria_id` = ''29'', `iva` = ''16'', `precio` = ''2500'', `stock_control` = ''N'', `descripcion` = '''', `interlocutor_id` = ''0000000010'' WHERE id_producto = ''7003''', '2016-09-03 04:43:35', '::1'),
(366, 4, 0000000006, 'producto', '`id_producto` = ''7003'', `nombre` = ''jugo de mango'', `nombre_corto` = ''mango'', `referencia` = '''', `producto_categoria_id` = ''29'', `iva` = ''16'', `precio` = ''2500'', `stock_control` = ''S'', `descripcion` = '''', `interlocutor_id` = ''0000000010'' WHERE id_producto = ''7003''', '2016-09-03 04:48:58', '::1'),
(367, 4, 0000000006, 'producto', '`id_producto` = ''7003'', `nombre` = ''jugo de mango'', `nombre_corto` = ''mango'', `referencia` = '''', `producto_categoria_id` = ''29'', `iva` = ''16'', `precio` = ''2500'', `stock_control` = ''N'', `descripcion` = '''', `interlocutor_id` = ''0000000010'' WHERE id_producto = ''7003''', '2016-09-03 05:15:14', '::1'),
(368, 4, 0000000006, 'producto', '`id_producto` = ''7008'', `nombre` = ''Poker'', `nombre_corto` = ''Poker'', `referencia` = ''CVZ001'', `producto_categoria_id` = ''30'', `iva` = ''16'', `precio` = ''3000'', `stock_control` = ''S'', `descripcion` = ''Cerveza Poker'', `interlocutor_id` = ''0000000010'' WHERE id_producto = ''7008''', '2016-09-03 05:15:36', '::1'),
(369, 5, 0000000006, 'producto', '`estado_id` = ''3'' WHERE  id_producto=7003 OR id_producto=7004 OR id_producto=7005 OR id_producto=7007', '2016-09-03 05:34:09', '::1'),
(370, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Jugo de Mango'' ,  ''Jugo Mango'' ,  ''JN001'' ,  ''29'' ,  ''16'' ,  ''0'' ,  ''N'' ,  ''Jugo de Mango'' ,  ''0000000010'' )', '2016-09-03 05:34:48', '::1'),
(371, 3, 0000000006, 'observacion', '`(`nombre`, `orden`, `interlocutor_id`) VALUES ( ''Con salsa'' ,  ''4'' ,  ''0000000010'' )', '2016-09-03 10:50:11', '::1'),
(372, 4, 0000000006, 'observacion', '`id_observacion` = ''77'', `nombre` = ''sin hielo'', `orden` = ''1'' WHERE id_observacion = ''77''', '2016-09-03 10:50:36', '::1'),
(373, 1, 0000000006, 'bar', '', '2016-09-03 20:28:58', '::1'),
(374, 1, 0000000006, 'bar', '', '2016-09-03 20:29:59', '::1'),
(375, 1, 0000000006, 'bar', '', '2016-09-03 20:34:27', '::1'),
(376, 1, 0000000006, 'bar', '', '2016-09-03 20:36:53', '::1'),
(377, 2, 0000000000, 'bar1', '111111', '2016-09-03 20:39:12', '::1'),
(378, 1, 0000000006, 'bar', '', '2016-09-03 20:39:23', '::1'),
(379, 1, 0000000006, 'bar', '', '2016-09-03 22:22:31', '::1'),
(380, 1, 0000000001, 'appadmin', '', '2016-09-04 04:25:24', '186.81.131.169'),
(381, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `interlocutor_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''bar'' ,  ''bar'' ,  ''2'' ,  ''2'' ,  ''0000000001'' ,  ''cedula'' ,  ''3342423'' ,  ''wdasdds'' ,  ''2342342342'' ,  ''2342342'' ,  ''1'' ,  ''1'' ,  ''Bar Unplugged'' ,  ''herman.torres@wisgroup.com.co'' )', '2016-09-04 05:20:08', '186.81.131.169'),
(382, 2, 0000000000, 'baradmin', '111111', '2016-09-04 05:20:47', '186.81.131.169'),
(383, 1, 0000000014, 'adminbar', '', '2016-09-04 05:22:24', '186.81.131.169'),
(384, 1, 0000000001, 'appadmin', '', '2016-09-04 05:51:53', '186.81.131.169'),
(385, 3, 0000000001, 'fw_usuario', '`(`id_usuario`, `interlocutor_id`, `usuario_perfil_id`, `nickname`, `nombre`, `apellido`, `num_documento`, `email`, `clave`) VALUES ( '''' ,  ''0000000001'' ,  ''1'' ,  ''alberto.acosta'' ,  ''Alberto'' ,  ''Acosta'' ,  ''4514614'' ,  ''alberto.acosta@wisgroup.com.co'' ,  ''e17b3c5d28c54721bebb10c69d3bf087e3b3076b'' )', '2016-09-04 05:54:14', '186.81.131.169'),
(386, 2, 0000000000, 'alberto.acosta', 'aacosta', '2016-09-04 05:54:41', '186.81.131.169'),
(387, 1, 0000000015, 'alberto.acosta', '', '2016-09-04 05:55:29', '186.81.131.169'),
(388, 1, 0000000001, 'appadmin', '', '2016-09-04 06:01:56', '186.81.131.169'),
(389, 4, 0000000001, 'fw_usuario', '`clave` = ''e54be67a44dbabbdfe0dd51a5bdc3b892dec7899'' WHERE id_usuario = ''0000000001''', '2016-09-04 06:05:46', '186.81.131.169'),
(390, 1, 0000000001, 'appadmin', '', '2016-09-04 06:06:16', '186.81.131.169'),
(391, 4, 0000000001, 'fw_interlocutor', '`id_interlocutor` = ''0000000014'', `nombre` = ''Unplugged'', `apellido` = ''bar'', `interlocutor_tipo_negocio_id` = ''2'', `interlocutor_clase_id` = ''2'', `interlocutor_id` = ''0000000001'', `tipo_documento` = ''cedula'', `num_documento` = ''3342423'', `direccion` = ''wdasdds'', `celular` = ''2342342342'', `telefono` = ''2342342'', `estado_id` = ''1'', `orden` = ''1'', `descripcion` = ''Bar Unplugged'', `email` = ''herman.torres@wisgroup.com.co'' WHERE id_interlocutor = ''0000000014''', '2016-09-04 06:13:27', '186.81.131.169'),
(392, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `interlocutor_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''Bajo'' ,  ''Fondo'' ,  ''2'' ,  ''2'' ,  ''0000000001'' ,  ''cedula'' ,  ''12234'' ,  ''asdad'' ,  ''1231231123'' ,  ''1231231'' ,  ''1'' ,  ''2'' ,  ''Bar Bajo Fondo'' ,  ''herman.torre@wisgroup.com.co'' )', '2016-09-04 06:14:50', '186.81.131.169'),
(393, 1, 0000000016, 'bajofondo', '', '2016-09-04 06:15:17', '186.81.131.169'),
(394, 4, 0000000016, 'fw_usuario', '`clave` = ''d24dfa8502af68746aa580498aab7618cd73e4ba'' WHERE id_usuario = ''0000000016''', '2016-09-04 06:16:10', '186.81.131.169'),
(395, 1, 0000000016, 'bajofondo', '', '2016-09-04 06:16:31', '186.81.131.169'),
(396, 2, 0000000000, 'appadmin', 'htorres10', '2016-09-04 07:28:40', '181.58.128.35'),
(397, 1, 0000000001, 'appadmin', '', '2016-09-04 07:29:05', '181.58.128.35'),
(398, 1, 0000000014, 'unplugged', '', '2016-09-04 07:40:19', '181.58.128.35'),
(399, 2, 0000000000, '', '', '2016-09-04 08:36:19', '181.58.128.35'),
(400, 1, 0000000006, 'bar', '', '2016-09-04 09:01:21', '181.58.128.35'),
(401, 1, 0000000006, 'bar', '', '2016-09-04 09:02:51', '181.58.128.35'),
(402, 1, 0000000015, 'alberto.acosta', '', '2016-09-04 22:46:42', '181.135.80.11'),
(403, 1, 0000000006, 'bar', '', '2016-09-04 22:47:33', '181.135.80.11'),
(404, 1, 0000000006, 'bar', '', '2016-09-05 00:09:52', '181.135.80.11'),
(405, 3, 0000000006, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''trago corto'' ,  ''4'' ,  '''' ,  ''0000000006'' ,  ''0000000010'' )', '2016-09-05 00:10:44', '181.135.80.11'),
(406, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''ale'' ,  ''ale'' ,  ''ale'' ,  ''30'' ,  ''16'' ,  ''4500'' ,  ''S'' ,  '''' ,  ''0000000010'' )', '2016-09-05 00:11:39', '181.135.80.11'),
(407, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''guaro'' ,  ''guaro'' ,  ''guaro'' ,  ''32'' ,  ''16'' ,  ''2000'' ,  ''N'' ,  '''' ,  ''0000000010'' )', '2016-09-05 00:12:22', '181.135.80.11'),
(408, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''botella rpn'' ,  ''btron'' ,  ''btron'' ,  ''30'' ,  ''16'' ,  ''40000'' ,  ''S'' ,  '''' ,  ''0000000010'' )', '2016-09-05 00:13:10', '181.135.80.11'),
(409, 3, 0000000006, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''123221123'' ,  ''ffulano'' ,  ''detal'' ,  ''3333333'' ,  ''3333333333'' ,  ''SDJHFA@DFKJA.COM'' ,  ''dfslkj'' ,  ''0000000010'' ,  ''3'' )', '2016-09-05 00:15:26', '181.135.80.11'),
(410, 1, 0000000014, 'unplugged', '', '2016-09-07 19:02:00', '190.128.90.247'),
(411, 3, 0000000014, 'fw_usuario', '`(`id_usuario`, `interlocutor_id`, `usuario_perfil_id`, `nickname`, `nombre`, `apellido`, `num_documento`, `email`, `clave`) VALUES ( '''' ,  ''0000000014'' ,  ''2'' ,  ''Julian '' ,  ''Mesero 1'' ,  ''Ramos'' ,  ''1088001913'' ,  ''thejuller@gmail.com'' ,  ''9c4bb000b688b4e142556f6b55725a744084b5b5'' )', '2016-09-07 19:02:51', '190.128.90.247'),
(412, 3, 0000000014, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Frappe'' ,  ''Frappe'' ,  ''Fr1'' ,  ''0'' ,  ''0'' ,  ''N'' ,  '''' ,  ''0000000014'' )', '2016-09-07 19:04:00', '190.128.90.247'),
(413, 3, 0000000014, 'mesa', '`(`nombre`, `descripcion`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''Mesa 1'' ,  ''Mesa 1'' ,  ''Mesa 1'' ,  '''' ,  ''0000000014'' )', '2016-09-07 19:04:56', '190.128.90.247'),
(414, 3, 0000000014, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Frappe Frutos Rojos'' ,  ''Ffr'' ,  ''Frp1'' ,  ''0'' ,  ''4500'' ,  ''N'' ,  ''Frape Frutos Rojos'' ,  ''0000000014'' )', '2016-09-07 19:06:34', '190.128.90.247'),
(415, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Bebidas Frias'' ,  ''1'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-09-07 19:07:07', '190.128.90.247'),
(416, 3, 0000000014, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Frappe Frutos Rojos'' ,  ''Frappe'' ,  ''F1'' ,  ''33'' ,  ''0'' ,  ''4500'' ,  ''N'' ,  ''Frappe Frutos Rojos'' ,  ''0000000014'' )', '2016-09-07 19:08:06', '190.128.90.247'),
(417, 1, 0000000014, 'Unplugged', '', '2016-09-07 19:34:03', '190.128.90.247'),
(418, 1, 0000000014, 'unplugged', '', '2016-09-12 05:03:55', '190.157.45.238'),
(419, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Bebidas Calientes'' ,  ''2'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-09-12 05:06:41', '190.157.45.238'),
(420, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Café'' ,  ''5'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-09-12 05:08:23', '190.157.45.238'),
(421, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Cervezas'' ,  ''3'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-09-12 05:08:43', '190.157.45.238'),
(422, 4, 0000000014, 'producto', '`id_producto` = ''7015'', `nombre` = ''Frappe Frutos Rojos'', `nombre_corto` = ''Frappe F R'', `referencia` = ''F1'', `producto_categoria_id` = ''33'', `iva` = ''0'', `precio` = ''4500'', `stock_control` = ''N'', `descripcion` = ''Frappe Frutos Rojos'', `interlocutor_id` = ''0000000014'' WHERE id_producto = ''7015''', '2016-09-12 05:11:38', '190.157.45.238'),
(423, 3, 0000000014, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Expresso'' ,  ''Expresso'' ,  ''C'' ,  ''34'' ,  ''0'' ,  ''2000'' ,  ''N'' ,  '''' ,  ''0000000014'' )', '2016-09-12 05:12:43', '190.157.45.238'),
(424, 3, 0000000014, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Club Colombia'' ,  ''Club Col'' ,  ''C1'' ,  ''36'' ,  ''0'' ,  ''4000'' ,  ''S'' ,  '''' ,  ''0000000014'' )', '2016-09-12 05:19:50', '190.157.45.238'),
(425, 3, 0000000014, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''999999'' ,  ''Bavaria'' ,  '''' ,  ''3333333'' ,  ''3333333333'' ,  ''asd@asd.com'' ,  ''asdasda'' ,  ''0000000014'' ,  ''3'' )', '2016-09-12 05:24:28', '190.157.45.238'),
(426, 4, 0000000014, 'fw_usuario', '`id_usuario` = ''0000000017'', `interlocutor_id` = ''0000000014'', `usuario_perfil_id` = ''2'', `nickname` = ''Julian '', `nombre` = ''Mesero 1'', `apellido` = ''Ramos'', `num_documento` = ''1088001913'', `email` = ''thejuller@gmail.com'', `clave` = ''1234'' WHERE id_usuario = ''0000000017''', '2016-09-12 05:40:34', '190.157.45.238'),
(427, 2, 0000000000, 'julian', '1234', '2016-09-12 05:40:59', '190.157.45.238'),
(428, 2, 0000000000, 'Julian', '1234', '2016-09-12 05:41:28', '190.157.45.238'),
(429, 2, 0000000000, '1088001913', '1234', '2016-09-12 05:41:45', '190.157.45.238'),
(430, 4, 0000000014, 'fw_usuario', '`id_usuario` = ''0000000017'', `interlocutor_id` = ''0000000014'', `usuario_perfil_id` = ''2'', `nickname` = ''Julian'', `nombre` = ''Mesero 1'', `apellido` = ''Ramos'', `num_documento` = ''1088001913'', `email` = ''thejuller@gmail.com'', `clave` = ''1234'' WHERE id_usuario = ''0000000017''', '2016-09-12 05:42:32', '190.157.45.238'),
(431, 2, 0000000000, 'Julian', '1234', '2016-09-12 05:42:39', '190.157.45.238'),
(432, 2, 0000000000, 'Julian', '1234', '2016-09-12 05:43:57', '190.157.45.238'),
(433, 2, 0000000000, 'Julian', '1234', '2016-09-12 05:44:31', '190.157.45.238'),
(434, 2, 0000000000, 'Julian', '1234', '2016-09-12 05:45:10', '190.157.45.238'),
(435, 4, 0000000014, 'fw_usuario', '`id_usuario` = ''0000000017'', `interlocutor_id` = ''0000000014'', `usuario_perfil_id` = ''2'', `nickname` = ''julian'', `nombre` = ''Mesero 1'', `apellido` = ''Ramos'', `num_documento` = ''1088001913'', `email` = ''thejuller@gmail.com'', `clave` = ''4321'' WHERE id_usuario = ''0000000017''', '2016-09-12 05:45:43', '190.157.45.238'),
(436, 4, 0000000014, 'fw_usuario', '`id_usuario` = ''0000000017'', `interlocutor_id` = ''0000000014'', `usuario_perfil_id` = ''2'', `nickname` = ''julian'', `nombre` = ''Mesero 1'', `apellido` = ''Ramos'', `num_documento` = ''1088001913'', `email` = ''thejuller@gmail.com'', `clave` = ''4321'' WHERE id_usuario = ''0000000017''', '2016-09-12 05:46:01', '190.157.45.238'),
(437, 2, 0000000000, 'julian', '4321', '2016-09-12 05:47:09', '190.157.45.238'),
(438, 3, 0000000014, 'fw_usuario', '`(`id_usuario`, `interlocutor_id`, `usuario_perfil_id`, `nickname`, `nombre`, `apellido`, `num_documento`, `email`, `clave`) VALUES ( '''' ,  ''0000000014'' ,  ''2'' ,  ''andrea.lopez'' ,  ''Andrea'' ,  ''Lopez'' ,  ''222222'' ,  ''asdasd@asd.com'' ,  ''5b0c3e3653c93b5fce5a34cd9628d1d83f1a1793'' )', '2016-09-12 05:48:55', '190.157.45.238'),
(439, 1, 0000000018, 'andrea.lopez', '', '2016-09-12 05:49:23', '190.157.45.238'),
(440, 1, 0000000018, 'andrea.lopez', '', '2016-09-12 05:50:12', '190.157.45.238'),
(441, 2, 0000000000, '', '', '2016-09-12 05:51:18', '190.157.45.238'),
(442, 1, 0000000018, 'andrea.lopez', '', '2016-09-12 06:35:17', '190.157.45.238'),
(443, 1, 0000000006, 'bar', '', '2016-09-14 21:06:40', '201.131.91.69'),
(444, 1, 0000000006, 'bar', '', '2016-09-19 20:53:13', '191.98.75.117'),
(445, 2, 0000000000, 'bar', '', '2016-09-20 04:49:49', '181.58.128.35'),
(446, 1, 0000000006, 'bar', '', '2016-09-20 04:50:14', '181.58.128.35'),
(447, 2, 0000000000, 'bar1', '111111', '2016-09-22 09:18:01', '190.128.60.157'),
(448, 1, 0000000006, 'bar', '', '2016-09-22 09:18:45', '190.128.60.157'),
(449, 1, 0000000006, 'bar', '', '2016-09-29 02:26:16', '181.63.44.5'),
(450, 2, 0000000000, 'bajofondo', '11111', '2016-09-29 02:26:28', '190.128.113.176'),
(451, 2, 0000000000, 'bajofondo', '111111', '2016-09-29 02:26:53', '190.128.113.176'),
(452, 1, 0000000016, 'bajofondo', '', '2016-09-29 02:28:23', '190.128.113.176'),
(453, 3, 0000000016, 'mesa', '`(`nombre`, `descripcion`, `orden`, `mesero_id`, `interlocutor_id`) VALUES ( ''Monalisa'' ,  '''' ,  ''1'' ,  '''' ,  ''0000000015'' )', '2016-09-29 02:34:33', '190.128.113.176'),
(454, 1, 0000000006, 'bar', '', '2016-09-29 02:38:55', '190.128.113.176'),
(455, 2, 0000000000, 'bar', '', '2016-10-05 21:22:16', '190.243.66.187'),
(456, 1, 0000000006, 'bar', '', '2016-10-05 21:22:35', '190.243.66.187'),
(457, 1, 0000000006, 'bar', '', '2016-10-05 21:47:05', '186.0.12.8'),
(458, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Producto Test Diego'' ,  ''PTD'' ,  ''0001'' ,  ''32'' ,  ''16'' ,  ''2000'' ,  ''S'' ,  '''' ,  ''0000000010'' )', '2016-10-05 21:47:59', '186.0.12.8'),
(459, 1, 0000000006, 'bar', '', '2016-10-27 02:18:53', '186.81.131.169'),
(460, 1, 0000000006, 'bar', '', '2016-10-28 01:06:12', '191.98.93.63'),
(461, 2, 0000000000, 'appadmin', '111111', '2016-10-28 01:15:53', '191.98.93.63'),
(462, 2, 0000000000, 'appadmin', '111111', '2016-10-28 01:16:14', '191.98.93.63'),
(463, 1, 0000000007, 'restaurante', '', '2016-10-28 01:16:46', '191.98.93.63'),
(464, 1, 0000000006, 'bar', '', '2016-10-28 01:21:10', '191.98.93.63'),
(465, 1, 0000000006, 'bar', '', '2016-11-06 20:27:39', '200.118.215.141'),
(466, 1, 0000000006, 'bar', '', '2016-11-07 06:31:59', '200.118.215.141'),
(467, 2, 0000000000, '', '', '2016-11-13 03:12:34', '190.127.196.46'),
(468, 1, 0000000006, 'bar', '', '2016-11-13 03:14:54', '190.127.196.46'),
(469, 1, 0000000006, 'bar', '', '2016-11-13 03:20:45', '190.127.196.46'),
(470, 1, 0000000006, 'bar', '', '2016-11-13 03:27:12', '190.128.16.41'),
(471, 1, 0000000014, 'unplugged', '', '2016-11-16 18:49:14', '190.128.90.247'),
(472, 5, 0000000014, 'producto_categoria', '`estado_id` = ''3'' WHERE  id_producto_categoria=33 OR id_producto_categoria=34 OR id_producto_categoria=36 OR id_producto_categoria=35', '2016-11-16 18:52:10', '190.128.90.247'),
(473, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Cafés'' ,  ''1'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-11-16 18:52:21', '190.128.90.247'),
(474, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Bebidas Frias'' ,  ''2'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-11-16 18:52:50', '190.128.90.247'),
(475, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Acompañar'' ,  ''3'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-11-16 18:53:02', '190.128.90.247'),
(476, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Bebidas Calientes'' ,  ''4'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-11-16 18:53:26', '190.128.90.247'),
(477, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Otras Bebidas'' ,  ''5'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-11-16 18:53:39', '190.128.90.247'),
(478, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Cervezas'' ,  ''6'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-11-16 18:53:53', '190.128.90.247'),
(479, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Cocteles'' ,  ''7'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-11-16 18:54:07', '190.128.90.247'),
(480, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Licores '' ,  ''8'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-11-16 18:54:22', '190.128.90.247'),
(481, 3, 0000000014, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `usuario_id`, `marca_blanca`) VALUES ( ''Comidas Ligeras'' ,  ''9'' ,  '''' ,  ''0000000014'' ,  ''0000000014'' )', '2016-11-16 18:54:52', '190.128.90.247'),
(482, 5, 0000000014, 'producto', '`estado_id` = ''3'' WHERE  id_producto=7015 OR id_producto=7016 OR id_producto=7017', '2016-11-16 18:55:14', '190.128.90.247'),
(483, 3, 0000000014, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Frappe Fusion'' ,  ''FFu'' ,  '''' ,  ''38'' ,  ''0'' ,  ''4500'' ,  ''N'' ,  ''Mango - Maracuya - Mora - Fresa - Piña - Lulo'' ,  ''0000000014'' )', '2016-11-16 18:57:16', '190.128.90.247'),
(484, 3, 0000000014, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Frappe Caramelo'' ,  ''FCa'' ,  '''' ,  ''38'' ,  ''0'' ,  ''5500'' ,  ''N'' ,  '''' ,  ''0000000014'' )', '2016-11-16 19:26:39', '190.128.90.247'),
(485, 3, 0000000014, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Frappe Milo'' ,  ''FMilo'' ,  '''' ,  ''38'' ,  ''0'' ,  ''5500'' ,  ''N'' ,  '''' ,  ''0000000014'' )', '2016-11-16 19:27:08', '190.128.90.247'),
(486, 3, 0000000014, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Frappe Oreo'' ,  ''FOreo'' ,  '''' ,  ''38'' ,  ''0'' ,  ''6000'' ,  ''N'' ,  '''' ,  ''0000000014'' )', '2016-11-16 19:27:37', '190.128.90.247'),
(487, 3, 0000000014, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Frappe Oreo'' ,  ''FOreo'' ,  '''' ,  ''38'' ,  ''0'' ,  ''6000'' ,  ''N'' ,  '''' ,  ''0000000014'' )', '2016-11-16 19:29:27', '190.128.90.247'),
(488, 3, 0000000014, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Smothie'' ,  ''SM'' ,  '''' ,  ''38'' ,  ''0'' ,  ''5000'' ,  ''N'' ,  '''' ,  ''0000000014'' )', '2016-11-16 19:29:46', '190.128.90.247'),
(489, 1, 0000000006, 'bar', '', '2016-11-23 03:28:47', '200.118.215.141'),
(490, 2, 0000000000, 'appadmin', '111111', '2016-12-08 09:36:51', '::1'),
(491, 2, 0000000000, 'appadmin', '111111', '2016-12-08 09:39:24', '::1'),
(492, 1, 0000000001, 'appadmin', '', '2016-12-08 09:40:05', '::1'),
(493, 4, 0000000001, 'fw_usuario', '`clave` = ''337cee421b526aaf0cb4ec2f7beec50eb8da2129'' WHERE id_usuario = ''0000000001''', '2016-12-09 09:24:44', '::1'),
(494, 4, 0000000001, 'fw_usuario', '`id_usuario` = ''0000000001'', `nombre` = ''HERMAN ADRIAN'', `apellido` = ''TORRES'', `num_documento` = ''1089378345'' WHERE id_usuario = ''0000000001''', '2016-12-09 09:36:26', '::1'),
(495, 4, 0000000001, 'fw_usuario', '`id_usuario` = ''0000000001'', `nombre` = ''HERMAN'', `apellido` = ''TORRES'', `num_documento` = ''1089378345'' WHERE id_usuario = ''0000000001''', '2016-12-09 09:45:32', '::1'),
(496, 4, 0000000001, 'fw_usuario', '`id_usuario` = ''0000000001'', `nombre` = ''HERMAN ADRIAN'', `apellido` = ''TORRES'', `num_documento` = ''1089378345'' WHERE id_usuario = ''0000000001''', '2016-12-09 09:46:25', '::1'),
(497, 2, 0000000000, 'bar', 'bar', '2016-12-09 10:38:00', '::1'),
(498, 1, 0000000006, 'bar', '', '2016-12-09 10:38:54', '::1'),
(499, 1, 0000000006, 'bar', '', '2016-12-15 05:38:59', '::1'),
(500, 1, 0000000001, 'appadmin', '', '2016-12-15 19:09:39', '::1'),
(501, 1, 0000000006, 'bar', '', '2016-12-15 21:40:33', '::1'),
(502, 1, 0000000006, 'bar', '', '2016-12-15 22:04:31', '::1'),
(503, 1, 0000000006, 'bar', '', '2016-12-15 22:22:57', '::1'),
(504, 1, 0000000006, 'bar', '', '2016-12-16 10:36:25', '192.168.0.14'),
(505, 1, 0000000006, 'bar', '', '2016-12-17 01:04:05', '::1'),
(506, 1, 0000000006, 'bar', '', '2016-12-17 01:22:04', '192.168.0.14'),
(507, 4, 0000000006, 'producto', '`id_producto` = ''7009'', `nombre` = ''Jugo de Mango'', `nombre_corto` = ''Jugo Mango'', `referencia` = ''JN001'', `producto_categoria_id` = ''29'', `iva` = ''16'', `precio` = ''0'', `stock_control` = ''N'', `descripcion` = ''Jugo de Mango'', `interlocutor_id` = ''0000000010'' WHERE id_producto = ''7009''', '2016-12-17 02:36:00', '::1'),
(508, 1, 0000000006, 'bar', '', '2016-12-17 02:56:55', '192.168.0.14'),
(509, 1, 0000000006, 'bar', '', '2016-12-17 03:09:29', '192.168.0.14'),
(510, 1, 0000000006, 'bar', '', '2016-12-17 03:22:41', '::1'),
(511, 4, 0000000006, 'producto_categoria', '`id_producto_categoria` = ''29'', `nombre` = ''jugos'', `orden` = ''1'', `descripcion` = ''juguitos'', `icon_id` = ''9'', `usuario_id` = ''0000000006'', `marca_blanca` = ''0000000010'' WHERE id_producto_categoria = ''29''', '2016-12-17 10:01:22', '::1'),
(512, 4, 0000000006, 'producto_categoria', '`id_producto_categoria` = ''30'', `nombre` = ''Cervezas'', `orden` = ''2'', `descripcion` = ''Cervezas'', `icon_id` = ''9'', `usuario_id` = ''0000000006'', `marca_blanca` = ''0000000010'' WHERE id_producto_categoria = ''30''', '2016-12-17 10:01:34', '::1'),
(513, 4, 0000000006, 'producto_categoria', '`id_producto_categoria` = ''31'', `nombre` = ''Crepes'', `orden` = ''3'', `descripcion` = ''Crepes'', `icon_id` = ''219'', `usuario_id` = ''0000000006'', `marca_blanca` = ''0000000010'' WHERE id_producto_categoria = ''31''', '2016-12-17 10:05:30', '::1'),
(514, 4, 0000000006, 'producto_categoria', '`id_producto_categoria` = ''32'', `nombre` = ''trago corto'', `orden` = ''4'', `descripcion` = '''', `icon_id` = ''9'', `usuario_id` = ''0000000006'', `marca_blanca` = ''0000000010'' WHERE id_producto_categoria = ''32''', '2016-12-17 11:23:22', '::1'),
(515, 4, 0000000006, 'producto_categoria', '`id_producto_categoria` = ''32'', `nombre` = ''trago corto'', `orden` = ''4'', `descripcion` = '''', `icon_id` = ''9'', `usuario_id` = ''0000000006'', `marca_blanca` = ''0000000010'' WHERE id_producto_categoria = ''32''', '2016-12-17 11:39:44', '::1'),
(516, 4, 0000000006, 'producto_categoria', '`id_producto_categoria` = ''32'', `nombre` = ''trago corto'', `orden` = ''4'', `descripcion` = '''', `icon_id` = ''9'', `usuario_id` = ''0000000006'', `marca_blanca` = ''0000000010'' WHERE id_producto_categoria = ''32''', '2016-12-17 11:40:29', '::1'),
(517, 4, 0000000006, 'producto', '`id_producto` = ''7009'', `nombre` = ''Jugo de Mango'', `nombre_corto` = ''Jugo Mango'', `referencia` = ''J001'', `producto_categoria_id` = ''29'', `iva` = ''16'', `precio` = ''2200'', `stock_control` = ''N'', `descripcion` = ''Jugo de Mango'', `interlocutor_id` = ''0000000010'' WHERE id_producto = ''7009''', '2016-12-17 20:50:15', '::1'),
(518, 1, 0000000006, 'bar', '', '2016-12-17 21:45:48', '192.168.0.20'),
(519, 1, 0000000006, 'bar', '', '2016-12-17 22:31:22', '::1'),
(520, 1, 0000000006, 'bar', '', '2016-12-19 21:28:41', '::1'),
(521, 1, 0000000006, 'bar', '', '2016-12-30 03:52:59', '::1'),
(522, 3, 0000000006, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `icon_id`, `usuario_id`, `marca_blanca`) VALUES ( ''Shots'' ,  ''5'' ,  '''' ,  ''9'' ,  ''0000000006'' ,  ''0000000010'' )', '2016-12-30 03:56:10', '::1'),
(523, 1, 0000000006, 'bar', '', '2017-01-04 08:54:48', '::1'),
(524, 1, 0000000006, 'bar', '', '2017-01-11 19:48:03', '::1'),
(525, 2, 0000000000, 'bar', 'bar', '2017-02-11 04:06:32', '::1'),
(526, 1, 0000000006, 'bar', '', '2017-02-11 04:06:41', '::1'),
(527, 1, 0000000008, 'comercio', '', '2017-02-22 23:27:14', '::1'),
(528, 1, 0000000006, 'bar', '', '2017-02-23 06:10:33', '::1'),
(529, 3, 0000000006, 'observacion', '`(`nombre`, `orden`, `interlocutor_id`) VALUES ( ''asdasd'' ,  ''1'' ,  ''0000000010'' )', '2017-02-23 11:26:51', '::1'),
(530, 3, 0000000006, 'fw_interlocutor', '`(`interlocutor_clase_id`, `nombre`, `apellido`, `num_documento`, `direccion`, `telefono`, `celular`, `email`, `estado_id`) VALUES ( ''3'' ,  ''asda fsdf sd'' ,  ''dasdasd'' ,  ''4312234'' ,  ''2sdfsdf'' ,  ''3234234'' ,  ''2342342'' ,  ''asdasd@asdas.com'' ,  ''1'' )', '2017-02-23 11:27:26', '::1'),
(531, 3, 0000000006, 'fw_interlocutor', '`(`interlocutor_clase_id`, `nombre`, `apellido`, `num_documento`, `direccion`, `telefono`, `celular`, `email`, `estado_id`) VALUES ( ''3'' ,  ''asda fsdf sd'' ,  ''dasdasd'' ,  ''4312234'' ,  ''2sdfsdf'' ,  ''3234234'' ,  ''2342342'' ,  ''asdasd@asdas.com'' ,  ''1'' )', '2017-02-23 11:29:11', '::1'),
(532, 3, 0000000006, 'fw_interlocutor', '`(`interlocutor_clase_id`, `nombre`, `apellido`, `num_documento`, `direccion`, `telefono`, `celular`, `email`, `estado_id`) VALUES ( ''3'' ,  ''asda fsdf sd'' ,  ''dasdasd'' ,  ''4312234'' ,  ''2sdfsdf'' ,  ''3234234'' ,  ''2342342'' ,  ''asdasd@asdas.com'' ,  ''1'' )', '2017-02-23 11:30:19', '::1'),
(533, 3, 0000000006, 'fw_interlocutor', '`(`interlocutor_clase_id`, `nombre`, `apellido`, `num_documento`, `direccion`, `telefono`, `celular`, `email`, `estado_id`) VALUES ( ''3'' ,  ''asda fsdf sd'' ,  ''dasdasd'' ,  ''4312234'' ,  ''2sdfsdf'' ,  ''3234234'' ,  ''2342342'' ,  ''asdasd@asdas.com'' ,  ''1'' )', '2017-02-23 11:31:29', '::1'),
(534, 3, 0000000006, 'fw_interlocutor', '`(`interlocutor_clase_id`, `nombre`, `apellido`, `num_documento`, `direccion`, `telefono`, `celular`, `email`, `estado_id`) VALUES ( ''3'' ,  ''qweqw'' ,  ''qweqweq'' ,  ''321321'' ,  ''ewrwer we'' ,  ''2342342342'' ,  ''234234234'' ,  ''sadasd@asdasd.com'' ,  ''1'' )', '2017-02-23 11:32:58', '::1'),
(535, 1, 0000000008, 'comercio', '', '2017-02-27 18:38:44', '::1'),
(536, 3, 0000000008, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `icon_id`, `usuario_id`, `marca_blanca`) VALUES ( ''Pañal'' ,  ''4'' ,  ''Pañales'' ,  ''9'' ,  ''0000000008'' ,  ''0000000012'' )', '2017-02-27 18:45:32', '::1'),
(537, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Winny Paquete x 20'' ,  ''winny'' ,  ''001'' ,  ''47'' ,  ''16'' ,  ''20000'' ,  ''S'' ,  ''Pañal Winny'' ,  ''0000000012'' )', '2017-02-27 18:46:23', '::1'),
(538, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''18520371'' ,  ''Herman'' ,  ''Torres Proveedor'' ,  ''3432991'' ,  ''3146063455'' ,  ''herman.torres@live.com'' ,  ''m1 cs 7'' ,  ''0000000012'' ,  ''3'' )', '2017-02-27 20:05:51', '::1'),
(539, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''1234'' ,  ''asdasd'' ,  ''2sfsdfsd'' ,  ''234234'' ,  ''2342342342'' ,  ''fsdfsdf@asfdas.com'' ,  ''asdasd'' ,  ''0000000012'' ,  ''3'' )', '2017-02-27 23:48:44', '::1'),
(540, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''123'' ,  ''weqweqwe'' ,  ''qeqweqw'' ,  ''12312312'' ,  ''1123123123'' ,  ''asdasd@asdasd.com'' ,  ''asdasda'' ,  ''0000000012'' ,  ''3'' )', '2017-02-27 23:52:43', '::1'),
(541, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''4514614'' ,  ''Alberto'' ,  ''Acosta Proveedor'' ,  ''123123123'' ,  ''123123123'' ,  ''alberto@gmail.com'' ,  ''adasda'' ,  ''0000000012'' ,  ''3'' )', '2017-02-28 00:16:17', '::1'),
(542, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''1087548119'' ,  ''Yesica'' ,  ''Botero'' ,  ''1231231'' ,  ''12312313'' ,  ''adas@ads.com'' ,  ''asdasdas dasda'' ,  ''0000000012'' ,  ''3'' )', '2017-02-28 00:22:38', '::1'),
(543, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''42067855'' ,  ''Amparo'' ,  ''Patiño'' ,  ''1243123123'' ,  ''1231231'' ,  ''asda@asda.com'' ,  ''asdasd'' ,  ''0000000012'' ,  ''3'' )', '2017-02-28 00:23:31', '::1'),
(544, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''4514614'' ,  ''Alberto Acosta'' ,  ''Cliente'' ,  ''3368710'' ,  ''3113777443'' ,  ''dfsklfj@dfjk.com'' ,  ''ñalksdlasdasf'' ,  ''0000000012'' ,  ''4'' )', '2017-02-28 00:31:00', '::1'),
(545, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''4514614'' ,  ''Alberto'' ,  ''Acosta Cliente'' ,  ''42342342'' ,  ''2342342'' ,  ''asda@asda.com'' ,  ''asda'' ,  ''0000000012'' ,  ''4'' )', '2017-02-28 00:34:03', '::1'),
(546, 1, 0000000001, 'appadmin', '', '2017-02-28 01:37:03', '::1'),
(547, 1, 0000000008, 'comercio', '', '2017-02-28 01:39:50', '::1'),
(548, 3, 0000000008, 'factura_numeracion', '`(`id_factura_numeracion`, `resolucion_numero`, `factura_actual`, `factura_minimo`, `factura_maximo`, `interlocutor_id`) VALUES ( '''' ,  ''3'' ,  ''1001'' ,  ''1001'' ,  ''2000'' ,  ''0000000012'' )', '2017-02-28 01:41:11', '::1'),
(549, 3, 0000000008, 'factura_numeracion', '`(`id_factura_numeracion`, `resolucion_numero`, `factura_actual`, `factura_minimo`, `factura_maximo`, `interlocutor_id`) VALUES ( '''' ,  ''3'' ,  ''1001'' ,  ''1001'' ,  ''2000'' ,  ''0000000012'' )', '2017-02-28 01:42:17', '::1'),
(550, 3, 0000000008, 'factura_numeracion', '`(`interlocutor_id`) VALUES ( ''0000000012'' )', '2017-02-28 01:43:06', '::1'),
(551, 5, 0000000008, 'factura_numeracion', '`estado_id` = ''3'' WHERE  id_factura_numeracion=4 OR id_factura_numeracion=5', '2017-02-28 01:43:27', '::1'),
(552, 1, 0000000008, 'comercio', '', '2017-02-28 17:26:33', '::1'),
(553, 5, 0000000008, 'producto', '`estado_id` = ''3'' WHERE  id_producto=6995 OR id_producto=6998 OR id_producto=7006', '2017-02-28 18:57:04', '::1'),
(554, 1, 0000000006, 'bar', '', '2017-03-02 19:33:31', '::1'),
(555, 1, 0000000006, 'bar', '', '2017-03-03 02:56:43', '::1'),
(556, 1, 0000000006, 'bar', '', '2017-03-03 17:41:12', '::1'),
(557, 1, 0000000006, 'bar', '', '2017-03-04 02:52:39', '::1'),
(558, 2, 0000000000, 'universidad', '111111', '2017-03-11 21:28:45', '::1'),
(559, 1, 0000000006, 'bar', '', '2017-03-11 21:28:53', '::1'),
(560, 1, 0000000008, 'comercio', '', '2017-03-11 21:29:46', '::1'),
(561, 1, 0000000008, 'comercio', '', '2017-03-13 03:30:13', '::1'),
(562, 1, 0000000008, 'comercio', '', '2017-03-13 04:06:16', '::1'),
(563, 1, 0000000008, 'comercio', '', '2017-03-14 04:21:27', '::1'),
(564, 1, 0000000006, 'bar', '', '2017-03-14 16:27:42', '::1'),
(565, 1, 0000000008, 'comercio', '', '2017-03-14 21:51:35', '::1'),
(566, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Pañitos'' ,  ''PP'' ,  ''002'' ,  ''700323232323232'' ,  ''25'' ,  ''16'' ,  ''15000'' ,  ''S'' ,  ''adasdada'' ,  ''0000000012'' )', '2017-03-15 03:22:18', '::1'),
(567, 1, 0000000008, 'comercio', '', '2017-03-15 23:57:09', '::1'),
(568, 1, 0000000008, 'comercio', '', '2017-03-17 02:39:03', '::1'),
(569, 1, 0000000008, 'comercio', '', '2017-03-17 04:00:32', '::1'),
(570, 1, 0000000008, 'comercio', '', '2017-03-17 21:24:48', '::1'),
(571, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''123456'' ,  ''asda'' ,  ''asda'' ,  ''12312'' ,  ''1231231231'' ,  ''asda@qweq.com'' ,  ''asds ds'' ,  ''0000000012'' ,  ''3'' )', '2017-03-18 05:41:25', '::1'),
(572, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `interlocutor_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''WIS test'' ,  ''dasd'' ,  ''1'' ,  ''4'' ,  ''0000000012'' ,  ''cedula'' ,  ''4123123123'' ,  ''aasdasd'' ,  ''1231231'' ,  ''3123123'' ,  ''1'' ,  ''0'' ,  ''asdasda'' ,  ''asda@asda.com'' )', '2017-03-18 06:36:14', '::1'),
(573, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `interlocutor_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''WIS test'' ,  ''dasd'' ,  ''1'' ,  ''4'' ,  ''0000000012'' ,  ''cedula'' ,  ''4123123123'' ,  ''aasdasd'' ,  ''1231231'' ,  ''3123123'' ,  ''1'' ,  ''0'' ,  ''asdasda'' ,  ''asda@asda.com'' )', '2017-03-18 07:15:16', '::1'),
(574, 3, 0000000008, 'fw_interlocutor', '`(``) VALUES ()', '2017-03-18 07:24:47', '::1'),
(575, 1, 0000000008, 'comercio', '', '2017-03-18 16:15:18', '::1'),
(576, 4, 0000000008, 'fw_usuario', '`id_usuario` = ''0000000008'', `nombre` = ''Unidad Comercial'', `apellido` = ''WIS TEST'', `num_documento` = ''333333333'' WHERE id_usuario = ''0000000008''', '2017-03-18 16:16:08', '::1'),
(577, 4, 0000000008, 'fw_usuario', '`clave` = ''337cee421b526aaf0cb4ec2f7beec50eb8da2129'' WHERE id_usuario = ''0000000008''', '2017-03-18 17:31:12', '::1'),
(578, 1, 0000000008, 'comercio', '', '2017-03-19 06:14:20', '181.50.113.155'),
(579, 1, 0000000008, 'comercio', '', '2017-03-19 06:17:53', '181.50.113.155'),
(580, 1, 0000000008, 'comercio', '', '2017-03-19 06:21:13', '181.50.113.155'),
(581, 1, 0000000008, 'comercio', '', '2017-03-19 13:55:45', '181.142.90.223'),
(582, 1, 0000000008, 'comercio', '', '2017-03-19 18:16:29', '181.142.90.223');
INSERT INTO `fw_log` (`id_log`, `tipo_log_id`, `usuario_id`, `comentario`, `descripcion`, `fecha`, `ip`) VALUES
(583, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `interlocutor_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''Yesica'' ,  ''Botero'' ,  ''1'' ,  ''4'' ,  ''0000000012'' ,  ''cedula'' ,  ''1087548119'' ,  ''carrera'' ,  ''3003321548'' ,  ''3256487'' ,  ''1'' ,  ''0'' ,  '''' ,  '''' )', '2017-03-19 18:17:21', '181.142.90.223'),
(584, 3, 0000000008, 'fw_interlocutor', '`(``) VALUES ()', '2017-03-19 18:19:17', '181.142.90.223'),
(585, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `interlocutor_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''Alberto'' ,  ''proveedor'' ,  ''1'' ,  ''3'' ,  ''0000000012'' ,  ''nit'' ,  ''45146141'' ,  ''calle'' ,  ''3115879658'' ,  ''3265848'' ,  ''1'' ,  ''0'' ,  '''' ,  '''' )', '2017-03-19 18:19:59', '181.142.90.223'),
(586, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''camionera'' ,  ''malla'' ,  ''gorra camionera'' ,  ''1112221'' ,  ''25'' ,  ''16'' ,  ''2500'' ,  ''S'' ,  '''' ,  ''0000000012'' )', '2017-03-19 18:20:47', '181.142.90.223'),
(587, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''lacost azul'' ,  ''lca'' ,  ''lacost'' ,  ''223154'' ,  ''26'' ,  ''16'' ,  ''25000'' ,  ''S'' ,  '''' ,  ''0000000012'' )', '2017-03-19 18:21:30', '181.142.90.223'),
(588, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''pampers'' ,  ''pm'' ,  ''pañal'' ,  ''2231546'' ,  ''47'' ,  ''16'' ,  ''1500'' ,  ''N'' ,  '''' ,  ''0000000012'' )', '2017-03-19 18:22:10', '181.142.90.223'),
(589, 1, 0000000008, 'comercio', '', '2017-03-20 15:19:16', '181.50.113.155'),
(590, 1, 0000000008, 'comercio', '', '2017-03-20 15:19:16', '181.50.113.155'),
(591, 1, 0000000008, 'comercio', '', '2017-03-20 17:14:06', '181.50.113.155'),
(592, 1, 0000000008, 'comercio', '', '2017-03-20 22:26:10', '181.142.90.223'),
(593, 1, 0000000006, 'bar', '', '2017-03-20 22:39:49', '181.142.90.223'),
(594, 1, 0000000008, 'comercio', '', '2017-03-21 03:41:09', '181.54.10.217'),
(595, 1, 0000000008, 'comercio', '', '2017-03-21 14:38:34', '181.142.90.223'),
(596, 1, 0000000008, 'comercio', '', '2017-03-21 14:41:12', '186.145.34.254'),
(597, 1, 0000000008, 'comercio', '', '2017-03-21 22:17:19', '181.142.90.223'),
(598, 3, 0000000008, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `icon_id`, `usuario_id`, `marca_blanca`) VALUES ( ''Servicios'' ,  ''0'' ,  '''' ,  ''20'' ,  ''0000000008'' ,  ''0000000012'' )', '2017-03-21 22:17:45', '181.142.90.223'),
(599, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Instalar cámara AHD'' ,  ''Cámara AHD'' ,  '''' ,  '''' ,  ''48'' ,  ''16'' ,  ''60000'' ,  ''N'' ,  ''instalación por punto con 3 metros de cable'' ,  ''0000000012'' )', '2017-03-21 22:18:47', '181.142.90.223'),
(600, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Instalacion de DVR'' ,  ''DVR'' ,  '''' ,  '''' ,  ''48'' ,  ''16'' ,  ''60000'' ,  ''N'' ,  '''' ,  ''0000000012'' )', '2017-03-21 22:19:15', '181.142.90.223'),
(601, 1, 0000000008, 'comercio', '', '2017-03-22 14:43:52', '190.249.121.35'),
(602, 3, 0000000008, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `icon_id`, `usuario_id`, `marca_blanca`) VALUES ( ''novenas'' ,  ''0'' ,  ''novenas'' ,  ''1'' ,  ''0000000008'' ,  ''0000000012'' )', '2017-03-22 14:45:11', '190.249.121.35'),
(603, 3, 0000000008, 'producto_categoria', '`(`nombre`, `orden`, `descripcion`, `icon_id`, `usuario_id`, `marca_blanca`) VALUES ( ''Velas'' ,  ''0'' ,  ''Velas'' ,  ''1'' ,  ''0000000008'' ,  ''0000000012'' )', '2017-03-22 14:45:28', '190.249.121.35'),
(604, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Vela grande'' ,  ''VG'' ,  ''vela'' ,  ''111222333'' ,  ''50'' ,  ''0'' ,  ''0'' ,  ''S'' ,  '''' ,  ''0000000012'' )', '2017-03-22 14:46:19', '190.249.121.35'),
(605, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Vela mediana roja'' ,  ''Vmr'' ,  ''Vela'' ,  ''velamr'' ,  ''50'' ,  ''0'' ,  ''0'' ,  ''S'' ,  '''' ,  ''0000000012'' )', '2017-03-22 14:47:09', '190.249.121.35'),
(606, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Vela Mediana Azul'' ,  ''VMa'' ,  ''vela'' ,  ''vma'' ,  ''50'' ,  ''0'' ,  ''0'' ,  ''S'' ,  '''' ,  ''0000000012'' )', '2017-03-22 14:48:04', '190.249.121.35'),
(607, 3, 0000000008, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''Vela Mediana Amarilla'' ,  ''Vmam'' ,  ''vela'' ,  '''' ,  ''50'' ,  ''0'' ,  ''0'' ,  ''S'' ,  '''' ,  ''0000000012'' )', '2017-03-22 14:48:41', '190.249.121.35'),
(608, 3, 0000000008, 'fw_interlocutor', '`(`id_interlocutor`, `tipo_documento`, `num_documento`, `nombre`, `apellido`, `telefono`, `celular`, `email`, `direccion`, `interlocutor_id`, `interlocutor_clase_id`) VALUES ( '''' ,  ''cedula'' ,  ''123123'' ,  ''julian'' ,  ''proveedor'' ,  ''333765749876'' ,  ''3776898'' ,  ''hkd@kd.com'' ,  '''' ,  ''0000000012'' ,  ''3'' )', '2017-03-22 14:51:01', '190.249.121.35'),
(609, 1, 0000000008, 'comercio', '', '2017-03-22 20:11:01', '181.128.110.59'),
(610, 1, 0000000006, 'bar', '', '2017-03-22 20:25:37', '181.128.110.59'),
(611, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''velas'' ,  ''vela5'' ,  '''' ,  '''' ,  ''29'' ,  ''16'' ,  ''1200'' ,  ''S'' ,  '''' ,  ''0000000010'' )', '2017-03-22 20:29:39', '181.128.110.59'),
(612, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''vela10'' ,  ''vela10'' ,  '''' ,  '''' ,  ''29'' ,  ''16'' ,  ''1500'' ,  ''S'' ,  '''' ,  ''0000000010'' )', '2017-03-22 20:30:10', '181.128.110.59'),
(613, 1, 0000000008, 'comercio', '', '2017-03-23 00:10:43', '181.142.90.223'),
(614, 1, 0000000006, 'bar', '', '2017-03-23 00:30:11', '181.142.90.223'),
(615, 1, 0000000008, 'comercio', '', '2017-03-23 21:45:30', '181.142.90.223'),
(616, 1, 0000000006, 'bar', '', '2017-03-27 21:43:10', '186.0.34.8'),
(617, 1, 0000000008, 'comercio', '', '2017-03-27 21:45:29', '186.0.34.8'),
(618, 1, 0000000008, 'comercio', '', '2017-03-28 22:35:18', '190.157.66.32'),
(619, 1, 0000000008, 'comercio', '', '2017-03-28 22:37:33', '190.157.66.32'),
(620, 1, 0000000006, 'bar', '', '2017-03-28 22:39:13', '190.157.66.32'),
(621, 1, 0000000006, 'bar', '', '2017-03-28 22:40:10', '181.54.10.217'),
(622, 1, 0000000008, 'comercio', '', '2017-03-28 22:55:10', '190.157.66.32'),
(623, 1, 0000000001, 'appadmin', '', '2017-03-29 01:09:47', '190.157.66.32'),
(624, 3, 0000000001, 'fw_interlocutor', '`(`id_interlocutor`, `nombre`, `apellido`, `interlocutor_tipo_negocio_id`, `interlocutor_clase_id`, `interlocutor_id`, `tipo_documento`, `num_documento`, `direccion`, `celular`, `telefono`, `estado_id`, `orden`, `descripcion`, `email`) VALUES ( '''' ,  ''Santiago'' ,  ''Polo'' ,  ''1'' ,  ''2'' ,  ''0000000001'' ,  ''cedula'' ,  ''11111111'' ,  ''xxxxxxx'' ,  ''1111111111'' ,  ''111111'' ,  ''1'' ,  ''1'' ,  ''Local Comercial'' ,  ''polo-santiago@hotmail.com'' )', '2017-03-29 01:12:13', '190.157.66.32'),
(625, 2, 0000000000, 'santiago', '111111', '2017-03-29 01:12:48', '190.157.66.32'),
(626, 1, 0000000023, 'santiago', '', '2017-03-29 01:13:56', '190.157.66.32'),
(627, 1, 0000000023, 'santiago', '', '2017-03-29 03:20:05', '190.157.66.32'),
(628, 1, 0000000023, 'santiago', '', '2017-03-30 18:59:39', '181.54.92.174'),
(629, 1, 0000000006, 'bar', '', '2017-03-30 22:05:47', '181.54.10.217'),
(630, 1, 0000000006, 'bar', '', '2017-03-30 22:06:44', '181.54.92.174'),
(631, 1, 0000000006, 'bar', '', '2017-04-01 17:14:07', '181.54.10.217'),
(632, 1, 0000000006, 'bar', '', '2017-04-01 17:18:19', '181.54.10.217'),
(633, 1, 0000000008, 'comercio', '', '2017-04-01 17:34:09', '181.54.10.217'),
(634, 1, 0000000006, 'bar', '', '2017-04-01 22:39:49', '181.60.3.195'),
(635, 3, 0000000006, 'producto', '`(`id_producto`, `nombre`, `nombre_corto`, `referencia`, `barcode`, `producto_categoria_id`, `iva`, `precio`, `stock_control`, `descripcion`, `interlocutor_id`) VALUES ( '''' ,  ''perro'' ,  ''perro'' ,  ''perro'' ,  ''2165654'' ,  ''30'' ,  ''16'' ,  ''2500'' ,  ''S'' ,  '''' ,  ''0000000010'' )', '2017-04-01 22:42:34', '181.60.3.195'),
(636, 1, 0000000008, 'comercio', '', '2017-04-01 22:45:41', '181.60.3.195'),
(637, 1, 0000000006, 'bar', '', '2017-04-03 18:57:36', '181.54.10.217'),
(638, 1, 0000000006, 'bar', '', '2017-04-03 20:30:25', '181.54.10.217'),
(639, 1, 0000000006, 'bar', '', '2017-04-03 20:55:32', '181.54.10.217');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_log_tipo`
--

CREATE TABLE IF NOT EXISTS `fw_log_tipo` (
  `id_log_tipo` tinyint(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id_log_tipo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `fw_log_tipo`
--

INSERT INTO `fw_log_tipo` (`id_log_tipo`, `nombre`) VALUES
(1, 'ingreso'),
(2, 'ingreso fallido'),
(3, 'crerar'),
(4, 'editar'),
(5, 'borrar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_opcion`
--

CREATE TABLE IF NOT EXISTS `fw_opcion` (
  `id_opcion` int(30) NOT NULL AUTO_INCREMENT,
  `opcion_id` varchar(15) DEFAULT NULL,
  `tipo` varchar(15) NOT NULL DEFAULT 'ITEM',
  `opcion_categoria_id` int(11) NOT NULL,
  `opcion_tipo_id` int(11) NOT NULL DEFAULT '1',
  `base` set('app','fw') NOT NULL DEFAULT 'app',
  `pack_id` int(11) NOT NULL DEFAULT '1',
  `descripcion` varchar(45) DEFAULT NULL,
  `imagen` varchar(60) DEFAULT NULL,
  `icon_id` int(11) NOT NULL,
  `estado_id` tinyint(3) unsigned DEFAULT NULL,
  `orden` int(20) DEFAULT NULL,
  `nombre_modulo` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id_opcion`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;

--
-- Volcado de datos para la tabla `fw_opcion`
--

INSERT INTO `fw_opcion` (`id_opcion`, `opcion_id`, `tipo`, `opcion_categoria_id`, `opcion_tipo_id`, `base`, `pack_id`, `descripcion`, `imagen`, `icon_id`, `estado_id`, `orden`, `nombre_modulo`) VALUES
(1, '0', 'MENU', 5, 1, 'app', 1, 'administración', '1.png', 3, 1, 3, 'administracion'),
(2, '1', 'ITEM', 5, 1, 'app', 6, 'transaccion', 'reporte_2.png', 3, 1, 2, 'transaccion'),
(3, '4', 'ITEM', 5, 2, 'app', 5, 'inventario fisico', '3.png', 3, 3, 3, 'inventario_fisico'),
(4, '0', 'MENU', 0, 0, 'app', 0, 'reportes', 'reporte_3.png', 3, 1, 2, 'reportes'),
(5, '1', 'ITEM', 0, 2, 'fw', 1, 'Configuración', '4.png', 26, 1, 50, 'configuracion'),
(7, '1', 'ITEM', 0, 2, 'app', 5, 'proveedores', '12.png', 231, 1, 6, 'proveedor2'),
(8, '1', 'ITEM', 0, 2, 'fw', 1, 'Usuarios', '2.png', 15, 1, 8, 'usuario'),
(9, '1', 'ITEM', 0, 2, 'app', 4, 'observaciones', 'administracion_2.png', 243, 1, 4, 'observacion'),
(10, '1', 'ITEM', 0, 2, 'app', 5, 'productos', '3.png', 18, 1, 1, 'producto'),
(11, '4', 'ITEM', 0, 2, 'app', 6, 'reporte de ventas', 'reporte_2.png', 207, 1, 11, 'ventas_reporte'),
(12, '4', 'ITEM', 0, 2, 'app', 6, 'reporte de compras', '5.png', 206, 1, 12, 'compras_reporte'),
(13, '4', 'ITEM', 0, 2, 'app', 5, 'reporte de inventario', '3.png', 39, 1, 13, 'inventario_reporte'),
(14, '1', 'ITEM', 5, 2, 'app', 4, 'mesas', 'mesas.png', 58, 1, 3, 'mesa'),
(15, '17', 'ITEM', 0, 1, 'app', 4, 'Toma de Pedidos', 'mesas.png', 8, 1, 15, 'pedido_recoleccion'),
(16, '1', 'ITEM', 1, 2, 'app', 5, 'Categorías de productos', '2.png', 19, 1, 2, 'producto_categoria'),
(17, '0', 'MENU', 0, 0, 'app', 6, 'Atención al Cliente', '1.png', 15, 1, 1, 'operacion'),
(18, '1', 'ITEM', 0, 2, 'fw', 1, 'Interlocutores', '1.png', 3, 1, 0, 'interlocutor'),
(19, '17', 'ITEM', 0, 1, 'app', 4, 'comandas', '1.png', 112, 1, 7, 'comandas'),
(20, '17', 'ITEM', 0, 4, 'app', 6, 'Compras', '1.png', 180, 1, 1, 'compras'),
(21, '17', 'ITEM', 0, 4, 'app', 6, 'Ventas', 'carrito.png', 119, 1, 2, 'ventas'),
(22, '27', 'ITEM', 0, 2, 'fw', 1, 'Cambio de Clave', NULL, 264, 1, NULL, 'usuario_cambio_clave'),
(23, '1', 'ITEM', 5, 2, 'app', 6, 'Numeracion de facturas', '4.png', 140, 1, 10, 'factura_numeracion'),
(24, '1', 'ITEM', 1, 1, 'fw', 1, 'permisos interlocutor', 'permisos.png', 15, 1, 1, 'opcion_clase'),
(25, '1', 'ITEM', 0, 1, 'fw', 1, 'permisos de usuarios', 'permisos.png', 264, 1, 9, 'opcion_clase'),
(26, '17', 'ITEM', 1, 1, 'app', 6, 'Facturar', 'mesas.png', 150, 1, 16, 'facturar'),
(27, '0', 'ITEM', 0, 2, 'fw', 1, 'Opciones de Usuario', 'sphere.png', 3, 1, 3, 'mi_perfil'),
(28, '4', 'ITEM', 5, 2, 'app', 6, 'Balance de Caja', '3.png', 142, 1, 4, 'caja_balance'),
(29, '1', 'ITEM', 0, 5, 'app', 7, 'Clientes', NULL, 15, 1, 1, 'cliente'),
(30, '1', 'ITEM', 0, 5, 'app', 7, 'Proveedores', NULL, 163, 1, 1, 'proveedor'),
(31, '27', 'ITEM', 0, 2, 'app', 1, 'Mi Perfil', NULL, 15, 1, 1, 'mi_perfil');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_opcion_categoria`
--

CREATE TABLE IF NOT EXISTS `fw_opcion_categoria` (
  `id_opcion_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `estado_id` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  PRIMARY KEY (`id_opcion_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_opcion_clase`
--

CREATE TABLE IF NOT EXISTS `fw_opcion_clase` (
  `opcion_id` int(30) NOT NULL DEFAULT '0',
  `interlocutor_clase_id` int(6) NOT NULL,
  `estado_id` tinyint(3) unsigned DEFAULT '1',
  `usuario_perfil_id` int(11) NOT NULL,
  `tipo_negocio_id` int(11) NOT NULL,
  `marca_blanca` int(10) unsigned zerofill NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `fw_opcion_clase`
--

INSERT INTO `fw_opcion_clase` (`opcion_id`, `interlocutor_clase_id`, `estado_id`, `usuario_perfil_id`, `tipo_negocio_id`, `marca_blanca`) VALUES
(18, 1, 1, 1, 4, 0000000000),
(24, 1, 1, 1, 4, 0000000000),
(16, 2, 1, 1, 2, 0000000000),
(25, 2, 1, 1, 2, 0000000000),
(10, 2, 1, 1, 2, 0000000000),
(5, 2, 1, 1, 2, 0000000000),
(8, 2, 1, 1, 2, 0000000000),
(3, 2, 2, 1, 2, 0000000000),
(11, 2, 1, 1, 2, 0000000000),
(12, 2, 1, 1, 2, 0000000000),
(13, 2, 1, 1, 2, 0000000000),
(14, 2, 1, 1, 2, 0000000000),
(15, 2, 1, 1, 2, 0000000000),
(9, 2, 1, 1, 2, 0000000000),
(19, 2, 1, 1, 2, 0000000000),
(9, 2, 2, 2, 2, 0000000010),
(14, 2, 2, 2, 2, 0000000010),
(15, 2, 1, 2, 2, 0000000010),
(19, 2, 1, 2, 2, 0000000010),
(5, 2, 2, 2, 2, 0000000010),
(8, 2, 2, 2, 2, 0000000010),
(10, 2, 2, 2, 2, 0000000010),
(16, 2, 2, 2, 2, 0000000010),
(11, 2, 1, 2, 2, 0000000010),
(12, 2, 1, 2, 2, 0000000010),
(13, 2, 1, 2, 2, 0000000010),
(16, 2, 1, 1, 1, 0000000000),
(25, 2, 1, 1, 1, 0000000000),
(10, 2, 1, 1, 1, 0000000000),
(5, 2, 1, 1, 1, 0000000000),
(8, 2, 1, 1, 1, 0000000000),
(3, 2, 1, 1, 1, 0000000000),
(11, 2, 1, 1, 1, 0000000000),
(12, 2, 1, 1, 1, 0000000000),
(13, 2, 1, 1, 1, 0000000000),
(20, 2, 1, 1, 1, 0000000000),
(21, 2, 1, 1, 1, 0000000000),
(5, 2, 1, 3, 2, 0000000010),
(8, 2, 1, 3, 2, 0000000010),
(10, 2, 1, 3, 2, 0000000010),
(16, 2, 1, 3, 2, 0000000010),
(11, 2, 1, 3, 2, 0000000010),
(12, 2, 1, 3, 2, 0000000010),
(13, 2, 1, 3, 2, 0000000010),
(19, 2, 1, 4, 2, 0000000010),
(5, 2, 1, 1, 3, 0000000000),
(20, 2, 1, 1, 2, 0000000000),
(26, 2, 1, 1, 2, 0000000000),
(26, 2, 1, 2, 2, 0000000010),
(25, 2, 1, 1, 4, 0000000000),
(8, 2, 1, 1, 4, 0000000000),
(15, 2, 1, 2, 2, 0000000014),
(19, 2, 1, 2, 2, 0000000014),
(23, 2, 1, 1, 2, 0000000010),
(7, 2, 1, 1, 2, 0000000000),
(23, 2, 1, 1, 1, 0000000010),
(28, 2, 1, 1, 1, 0000000010),
(28, 2, 1, 1, 2, 0000000000),
(29, 2, 1, 1, 2, 0000000000),
(29, 2, 1, 1, 1, 0000000000),
(30, 2, 1, 1, 1, 0000000000),
(30, 2, 1, 1, 2, 0000000000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_opcion_tipo`
--

CREATE TABLE IF NOT EXISTS `fw_opcion_tipo` (
  `id_opcion_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_opcion_tipo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `fw_opcion_tipo`
--

INSERT INTO `fw_opcion_tipo` (`id_opcion_tipo`, `nombre`, `estado_id`) VALUES
(1, 'modulo', 1),
(2, 'maestro', 1),
(3, 'reporte', 1),
(4, 'operaciones', 1),
(5, 'interlocutor', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_pack`
--

CREATE TABLE IF NOT EXISTS `fw_pack` (
  `id_pack` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_pack`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `fw_pack`
--

INSERT INTO `fw_pack` (`id_pack`, `nombre`, `estado_id`) VALUES
(1, 'base', 1),
(2, 'tools', 1),
(3, 'reservado', 1),
(4, 'pedido', 1),
(5, 'stock', 1),
(6, 'transaccion', 1),
(7, 'interlocutor', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_tema`
--

CREATE TABLE IF NOT EXISTS `fw_tema` (
  `id_tema` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(30) DEFAULT NULL,
  `estado_id` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_tema`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `fw_tema`
--

INSERT INTO `fw_tema` (`id_tema`, `descripcion`, `estado_id`) VALUES
(1, 'comercio', 1),
(2, 'bar', 1),
(3, 'restaurante', 1),
(4, 'wis', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_usuario`
--

CREATE TABLE IF NOT EXISTS `fw_usuario` (
  `id_usuario` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL,
  `nickname` varchar(30) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `email` varchar(60) NOT NULL,
  `usuario_perfil_id` int(6) NOT NULL DEFAULT '1',
  `clave` varchar(40) NOT NULL,
  `estado_id` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_usuario`),
  KEY `index_usuario_owner_login` (`interlocutor_id`,`id_usuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Volcado de datos para la tabla `fw_usuario`
--

INSERT INTO `fw_usuario` (`id_usuario`, `interlocutor_id`, `nickname`, `nombre`, `apellido`, `num_documento`, `email`, `usuario_perfil_id`, `clave`, `estado_id`) VALUES
(0000000001, 0000000001, 'appadmin', 'HERMAN ADRIAN', 'TORRES', '1089378345', 'herman.torres@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000006, 0000000010, 'bar', 'bar', 'bar', '1111111111', 'bar@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000007, 0000000011, 'restaurante', 'restaurante', 'restaurante', '222222222', 'restaurante@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000008, 0000000012, 'comercio', 'Unidad Comercial', 'WIS TEST', '333333333', 'comercio@gmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000010, 0000000010, 'mesabar', 'mesero', 'mesero', '10987887656', 'mesero@gmail.com', 2, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000011, 0000000011, 'mesarestaurante', 'mesero', 'mesero', '19898767890', 'mesa@gmail.com', 2, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000012, 0000000012, 'wdpinto', 'wilson', 'pinto', '1088293892', 'daniel.p_2407@hotmail.com', 1, 'd749591bd3c16abe08fb63914011d088d64f3020', 1),
(0000000013, 0000000010, 'wdaniel', 'daniel', 'pinto', '102938472', 'daniel@hotmail.co', 1, 'beaa5dfd32a64a9298926ccb8fbe416556975432', 1),
(0000000014, 0000000014, 'unplugged', 'Admin', 'bar', '3342423', 'herman.torres@wisgroup.com.co', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000015, 0000000001, 'alberto.acosta', 'Alberto', 'Acosta', '4514614', 'alberto.acosta@wisgroup.com.co', 1, 'e17b3c5d28c54721bebb10c69d3bf087e3b3076b', 1),
(0000000016, 0000000015, 'bajofondo', 'Bajo', 'Fondo', '12234', 'herman.torre@wisgroup.com.co', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000017, 0000000014, 'julian', 'Mesero 1', 'Ramos', '1088001913', 'thejuller@gmail.com', 2, '4321', 1),
(0000000018, 0000000014, 'andrea.lopez', 'Andrea', 'Lopez', '222222', 'asdasd@asd.com', 2, '5b0c3e3653c93b5fce5a34cd9628d1d83f1a1793', 1),
(0000000019, 0000000000, '', 'WIS test', 'dasd', '4123123123', 'asda@asda.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000020, 0000000000, '', 'WIS test', 'dasd', '4123123123', 'asda@asda.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000021, 0000000000, '', 'Yesica', 'Botero', '1087548119', '', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000022, 0000000000, '', 'Alberto', 'proveedor', '45146141', '', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1),
(0000000023, 0000000037, 'santiago', 'Santiago', 'Polo', '11111111', 'polo-santiago@hotmail.com', 1, '337cee421b526aaf0cb4ec2f7beec50eb8da2129', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fw_usuario_perfil`
--

CREATE TABLE IF NOT EXISTS `fw_usuario_perfil` (
  `id_usuario_perfil` int(6) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `estado_id` tinyint(3) unsigned DEFAULT NULL,
  `marca_blanca` varchar(15) NOT NULL,
  PRIMARY KEY (`id_usuario_perfil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `fw_usuario_perfil`
--

INSERT INTO `fw_usuario_perfil` (`id_usuario_perfil`, `nombre`, `estado_id`, `marca_blanca`) VALUES
(1, 'Administrador', 1, '0000000001'),
(2, 'mesero', 1, '0000000001'),
(3, 'caja', 1, '0000000001'),
(4, 'cocina', 1, '0000000001');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=126 ;

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
(9, '9', '', 11, 0, 8, 0000000001),
(10, '10', '', 11, 0, 9, 0000000001),
(11, '11', '', 11, 0, 10, 0000000001),
(101, '13', '13', 11, 0, 13, 0000000001),
(102, '1', '1', 11, 0, 0, 0000000002),
(103, '2', '2', 11, 0, 2, 0000000002),
(104, '3', '3', 11, 0, 3, 0000000002),
(105, '5', '5', 11, 0, 5, 0000000002),
(106, 'M1', 'M1', 11, 0, 1, 0000000003),
(107, 'Mesa 2', '', 11, 0, 2, 0000000003),
(108, 'Mesa 3', '', 11, 0, 3, 0000000003),
(109, 'Mesa 4', '', 11, 0, 4, 0000000003),
(110, 'M1', '', 11, 0, 1, 0000000003),
(111, 'Mesa 2', '', 11, 0, 2, 0000000003),
(112, 'M2', '', 11, 0, 2, 0000000003),
(113, 'M3', '', 11, 0, 3, 0000000003),
(114, 'VIP', 'mesa 1', 11, 0, 7, 0000000011),
(115, '2', 'mesa 2', 11, 0, 1, 0000000011),
(116, '3', 'mesa 3', 11, 0, 2, 0000000011),
(117, '4', 'Mesa 0', 11, 0, 3, 0000000011),
(118, 'Mesa 1', 'Mesa 1', 13, 0, 1, 0000000010),
(119, 'Mesa 2', 'Mesa 2', 13, 0, 2, 0000000010),
(120, 'Mesa 3', 'Mesa 3', 13, 0, 3, 0000000010),
(121, 'Mesa 4', 'Mesa 4', 13, 0, 4, 0000000010),
(122, 'Mesa 5', 'Mesa 5', 13, 0, 5, 0000000010),
(123, 'mesa', 'mesa buena', 13, 0, 1, 0000000010),
(124, 'Mesa 1', 'Mesa 1', 11, 0, 0, 0000000014),
(125, 'Monalisa', '', 11, 0, 1, 0000000015);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=81 ;

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
(71, 'cerveza', 1, 1, 0000000003),
(72, 'sin cebollas', 1, 1, 0000000012),
(73, 'sin ripio', 0, 1, 0000000012),
(74, 'sin hielos', 1, 1, 0000000011),
(75, 'asado 3/4', 1, 1, 0000000011),
(77, 'sin hielo', 1, 1, 0000000010),
(1, 'sin observacion', 0, 1, 0000000000),
(78, 'sin azucar', 2, 1, 0000000010),
(79, 'Con salsa', 4, 1, 0000000010),
(80, 'asdasd', 1, 1, 0000000010);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE IF NOT EXISTS `pedido` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `cuenta_id` int(20) unsigned zerofill NOT NULL,
  `mesero_id` int(11) NOT NULL,
  `mesa_id` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '16',
  `fecha_publicacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_despachado` datetime DEFAULT NULL,
  `interlocutor_id` int(10) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id_pedido`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `cuenta_id`, `mesero_id`, `mesa_id`, `estado_id`, `fecha_publicacion`, `fecha_despachado`, `interlocutor_id`) VALUES
(1, 00000000000000000001, 6, 118, 15, '2017-03-22 20:31:14', NULL, 0000000010),
(2, 00000000000000000002, 6, 123, 15, '2017-03-27 21:44:06', NULL, 0000000010),
(3, 00000000000000000003, 6, 120, 15, '2017-03-28 22:41:20', NULL, 0000000010),
(4, 00000000000000000004, 6, 121, 15, '2017-03-30 22:06:57', NULL, 0000000010),
(5, 00000000000000000003, 6, 120, 15, '2017-03-30 22:07:19', NULL, 0000000010),
(6, 00000000000000000001, 6, 118, 15, '2017-03-30 22:07:43', NULL, 0000000010),
(7, 00000000000000000005, 6, 119, 15, '2017-03-30 22:08:06', NULL, 0000000010),
(8, 00000000000000000002, 6, 123, 15, '2017-03-30 22:08:26', NULL, 0000000010),
(9, 00000000000000000002, 6, 123, 15, '2017-03-30 22:12:56', NULL, 0000000010),
(10, 00000000000000000006, 6, 122, 15, '2017-04-01 17:18:49', NULL, 0000000010),
(11, 00000000000000000001, 6, 118, 15, '2017-04-01 22:40:41', NULL, 0000000010),
(12, 00000000000000000002, 6, 123, 15, '2017-04-01 22:42:49', NULL, 0000000010),
(13, 00000000000000000002, 6, 123, 15, '2017-04-03 19:14:01', NULL, 0000000010),
(14, 00000000000000000005, 6, 119, 15, '2017-04-03 19:15:53', NULL, 0000000010),
(15, 00000000000000000002, 6, 123, 15, '2017-04-03 20:31:21', NULL, 0000000010),
(16, 00000000000000000005, 6, 119, 15, '2017-04-03 20:31:31', NULL, 0000000010),
(17, 00000000000000000005, 6, 119, 15, '2017-04-03 20:55:57', NULL, 0000000010);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Volcado de datos para la tabla `pedido_item`
--

INSERT INTO `pedido_item` (`id_pedido_item`, `pedido_id`, `producto_id`, `cantidad`, `observacion_id`, `estado_id`) VALUES
(1, 1, 10, 9, 1, 17),
(2, 1, 11, 6, 1, 17),
(3, 2, 10, 14, 1, 17),
(4, 3, 10, 2, 1, 17),
(5, 3, 11, 3, 1, 17),
(6, 4, 10, 1, 1, 17),
(7, 4, 11, 1, 1, 17),
(8, 5, 10, 1, 1, 17),
(9, 5, 11, 1, 1, 17),
(10, 6, 10, 1, 1, 17),
(11, 6, 11, 1, 1, 17),
(12, 7, 11, 1, 1, 17),
(13, 8, 10, 1, 1, 17),
(14, 8, 11, 4, 1, 17),
(15, 9, 10, 3, 1, 17),
(16, 10, 10, 4, 1, 17),
(17, 10, 11, 1, 1, 17),
(18, 11, 10, 1, 1, 17),
(19, 11, 11, 1, 1, 17),
(20, 12, 12, 4, 1, 16),
(21, 13, 10, 1, 1, 16),
(22, 14, 10, 1, 1, 17),
(23, 14, 11, 1, 1, 17),
(24, 15, 10, 1, 1, 15),
(25, 15, 11, 1, 1, 15),
(26, 16, 10, 1, 1, 16),
(27, 16, 11, 1, 1, 15),
(28, 17, 12, 1, 1, 17);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proceso`
--

CREATE TABLE IF NOT EXISTS `proceso` (
  `id_proceso` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `referencia` varchar(10) NOT NULL,
  `interlocutor_owner_id` int(10) unsigned zerofill NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_proceso`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `proceso`
--

INSERT INTO `proceso` (`id_proceso`, `nombre`, `referencia`, `interlocutor_owner_id`, `estado_id`) VALUES
(1, 'PEDIDOS', 'WPP', 0000000001, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proceso_estado`
--

CREATE TABLE IF NOT EXISTS `proceso_estado` (
  `id_proceso_estado` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proceso_id` int(11) NOT NULL,
  `proceso_estado_id` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `orden` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `proceso_estado_pre_id` int(11) NOT NULL,
  `proceso_estado_post_id` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL,
  PRIMARY KEY (`id_proceso_estado`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `proceso_estado`
--

INSERT INTO `proceso_estado` (`id_proceso_estado`, `proceso_id`, `proceso_estado_id`, `nombre`, `orden`, `proceso_estado_pre_id`, `proceso_estado_post_id`, `estado_id`) VALUES
(1, 1, 15, 'PEDIDO_TOMADO', 1, 0, 2, 1),
(2, 1, 16, 'PEDIDO_SERVIDO', 2, 1, 3, 1),
(3, 1, 17, 'PEDIDO_ENTREGADO', 3, 2, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE IF NOT EXISTS `producto` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `referencia` varchar(50) NOT NULL,
  `barcode` varchar(30) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `nombre_corto` varchar(20) NOT NULL,
  `producto_categoria_id` int(11) NOT NULL DEFAULT '1',
  `iva` int(11) NOT NULL DEFAULT '16',
  `iva_incluido` set('S','N') NOT NULL DEFAULT 'S',
  `costo` bigint(10) NOT NULL DEFAULT '0',
  `precio` bigint(10) NOT NULL DEFAULT '0',
  `imagen` varchar(30) NOT NULL DEFAULT 'default.jpg',
  `descripcion` longtext NOT NULL,
  `unidad_medida_id` int(11) NOT NULL DEFAULT '0',
  `stock_control` set('S','N') NOT NULL DEFAULT 'N',
  `estante` varchar(20) NOT NULL,
  `orden` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '1',
  `interlocutor_id` int(10) unsigned zerofill NOT NULL DEFAULT '0000000000',
  PRIMARY KEY (`id_producto`),
  KEY `interlocutor_id` (`interlocutor_id`),
  KEY `estado_id` (`estado_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `referencia`, `barcode`, `nombre`, `nombre_corto`, `producto_categoria_id`, `iva`, `iva_incluido`, `costo`, `precio`, `imagen`, `descripcion`, `unidad_medida_id`, `stock_control`, `estante`, `orden`, `estado_id`, `interlocutor_id`) VALUES
(1, 'gorra camionera', '1112221', 'camionera', 'malla', 25, 16, 'S', 0, 2500, 'default.jpg', '', 0, 'S', '', 0, 1, 0000000012),
(2, 'lacost', '223154', 'lacost azul', 'lca', 26, 16, 'S', 0, 25000, '2.jpg', '', 0, 'S', '', 0, 1, 0000000012),
(3, 'pañal', '2231546', 'pampers', 'pm', 47, 16, 'S', 0, 1500, 'default.jpg', '', 0, 'N', '', 0, 1, 0000000012),
(4, '', '', 'Instalar cámara AHD', 'Cámara AHD', 48, 16, 'S', 0, 60000, 'default.jpg', 'instalación por punto con 3 metros de cable', 0, 'N', '', 0, 1, 0000000012),
(5, '', '', 'Instalacion de DVR', 'DVR', 48, 16, 'S', 0, 60000, 'default.jpg', '', 0, 'N', '', 0, 1, 0000000012),
(6, 'vela', '111222333', 'Vela grande', 'VG', 50, 0, 'S', 0, 0, 'default.jpg', '', 0, 'S', '', 0, 1, 0000000012),
(7, 'Vela', 'velamr', 'Vela mediana roja', 'Vmr', 50, 0, 'S', 0, 0, 'default.jpg', '', 0, 'S', '', 0, 1, 0000000012),
(8, 'vela', 'vma', 'Vela Mediana Azul', 'VMa', 50, 0, 'S', 0, 0, 'default.jpg', '', 0, 'S', '', 0, 1, 0000000012),
(9, 'vela', '', 'Vela Mediana Amarilla', 'Vmam', 50, 0, 'S', 0, 0, 'default.jpg', '', 0, 'S', '', 0, 1, 0000000012),
(10, '', '', 'velas', 'vela5', 29, 16, 'S', 0, 1200, 'default.jpg', '', 0, 'S', '', 0, 1, 0000000010),
(11, '', '', 'vela10', 'vela10', 29, 16, 'S', 0, 1500, 'default.jpg', '', 0, 'S', '', 0, 1, 0000000010),
(12, 'perro', '2165654', 'perro', 'perro', 30, 16, 'S', 0, 2500, 'default.jpg', '', 0, 'S', '', 0, 1, 0000000010);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_categoria`
--

CREATE TABLE IF NOT EXISTS `producto_categoria` (
  `id_producto_categoria` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(70) CHARACTER SET latin1 NOT NULL,
  `orden` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '1',
  `descripcion` varchar(300) CHARACTER SET latin1 NOT NULL,
  `icon_id` int(11) NOT NULL DEFAULT '0',
  `usuario_id` int(10) unsigned zerofill NOT NULL,
  `marca_blanca` int(10) unsigned zerofill NOT NULL,
  UNIQUE KEY `id_productos_categoria` (`id_producto_categoria`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=51 ;

--
-- Volcado de datos para la tabla `producto_categoria`
--

INSERT INTO `producto_categoria` (`id_producto_categoria`, `nombre`, `orden`, `estado_id`, `descripcion`, `icon_id`, `usuario_id`, `marca_blanca`) VALUES
(25, 'gorras', 1, 1, 'todas las gorras', 0, 0000000008, 0000000012),
(26, 'camisas', 2, 1, 'camisetas', 0, 0000000008, 0000000012),
(27, 'jugos', 1, 1, 'todos los jugos', 0, 0000000007, 0000000011),
(28, 'carnes asadas', 2, 1, 'disfrute de nuestros mejores cortes de carne de res, cerdo o pollo asados al carbon', 0, 0000000007, 0000000011),
(29, 'jugos', 1, 1, 'juguitos', 9, 0000000006, 0000000010),
(30, 'Cervezas', 2, 1, 'Cervezas', 9, 0000000006, 0000000010),
(31, 'Crepes', 3, 1, 'Crepes', 219, 0000000006, 0000000010),
(32, 'trago corto', 4, 1, '', 9, 0000000006, 0000000010),
(33, 'Bebidas Frias', 1, 3, '', 0, 0000000014, 0000000014),
(34, 'Bebidas Calientes', 2, 3, '', 0, 0000000014, 0000000014),
(35, 'Café', 5, 3, '', 0, 0000000014, 0000000014),
(36, 'Cervezas', 3, 3, '', 0, 0000000014, 0000000014),
(37, 'Cafés', 1, 1, '', 0, 0000000014, 0000000014),
(38, 'Bebidas Frias', 2, 1, '', 0, 0000000014, 0000000014),
(39, 'Acompañar', 3, 1, '', 0, 0000000014, 0000000014),
(40, 'Bebidas Calientes', 4, 1, '', 0, 0000000014, 0000000014),
(41, 'Otras Bebidas', 5, 1, '', 0, 0000000014, 0000000014),
(42, 'Cervezas', 6, 1, '', 0, 0000000014, 0000000014),
(43, 'Cocteles', 7, 1, '', 0, 0000000014, 0000000014),
(44, 'Licores ', 8, 1, '', 0, 0000000014, 0000000014),
(45, 'Comidas Ligeras', 9, 1, '', 0, 0000000014, 0000000014),
(46, 'Shots', 5, 1, '', 9, 0000000006, 0000000010),
(47, 'Pañal', 4, 1, 'Pañales', 9, 0000000008, 0000000012),
(48, 'Servicios', 0, 1, '', 20, 0000000008, 0000000012),
(49, 'novenas', 0, 1, 'novenas', 1, 0000000008, 0000000012),
(50, 'Velas', 0, 1, 'Velas', 1, 0000000008, 0000000012);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_stock`
--

CREATE TABLE IF NOT EXISTS `producto_stock` (
  `id_producto_stock` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT '0',
  `stock_minimo` int(11) NOT NULL DEFAULT '0',
  `stock_maximo` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_producto_stock`),
  KEY `producto_id` (`producto_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `producto_stock`
--

INSERT INTO `producto_stock` (`id_producto_stock`, `producto_id`, `stock`, `stock_minimo`, `stock_maximo`) VALUES
(1, 1, 45, 0, 0),
(2, 2, 22, 0, 0),
(3, 3, 0, 0, 0),
(4, 4, 0, 0, 0),
(5, 5, 0, 0, 0),
(6, 6, 8, 0, 0),
(7, 7, 15, 0, 0),
(8, 8, 1, 0, 0),
(9, 9, 0, 0, 0),
(10, 10, 1, 0, 0),
(11, 11, 0, 0, 0),
(12, 12, 100, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `referencia`
--

CREATE TABLE IF NOT EXISTS `referencia` (
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
-- Volcado de datos para la tabla `referencia`
--

INSERT INTO `referencia` (`id_referencias`, `referencia`, `nombre`, `descripcion`, `color_id`, `estado`, `orden`) VALUES
(1, '', 'MAGY LI MK', '', 0, 'E', 0),
(2, '', 'MONICA CABALLERO', '', 0, 'E', 0),
(3, 'blanco', 'blanco', '', 3, 'E', 0),
(4, 'SRM-1201', 'blanco', '', 3, 'E', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaccion`
--

CREATE TABLE IF NOT EXISTS `transaccion` (
  `id_transaccion` int(11) NOT NULL AUTO_INCREMENT,
  `cuenta_id` int(11) NOT NULL DEFAULT '0',
  `factura_numero` varchar(100) NOT NULL,
  `transaccion_tipo_id` int(11) NOT NULL,
  `responsable_id` int(11) NOT NULL,
  `interlocutor_id` int(10) unsigned zerofill DEFAULT NULL,
  `interlocutor_externo` int(10) unsigned zerofill NOT NULL,
  `observacion` text NOT NULL,
  `subtotal` int(10) unsigned NOT NULL DEFAULT '0',
  `servicio` int(10) unsigned NOT NULL DEFAULT '0',
  `impuesto` int(10) unsigned NOT NULL DEFAULT '0',
  `total` int(10) unsigned NOT NULL DEFAULT '0',
  `estado_id` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_transaccion`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `transaccion`
--

INSERT INTO `transaccion` (`id_transaccion`, `cuenta_id`, `factura_numero`, `transaccion_tipo_id`, `responsable_id`, `interlocutor_id`, `interlocutor_externo`, `observacion`, `subtotal`, `servicio`, `impuesto`, `total`, `estado_id`, `fecha`) VALUES
(1, 0, '', 2, 0, 0000000012, 0000000035, '', 0, 0, 0, 760000, 1, '2017-03-20 22:27:48'),
(2, 0, '227', 1, 0, 0000000012, 0000000034, '', 0, 0, 0, 525000, 1, '2017-03-20 22:28:48'),
(3, 0, '', 2, 0, 0000000012, 0000000035, '', 0, 0, 0, 600000, 1, '2017-03-20 22:29:59'),
(4, 0, '', 2, 0, 0000000012, 0000000035, '', 0, 0, 0, 15000, 1, '2017-03-20 22:30:49'),
(5, 0, '', 2, 0, 0000000012, 0000000608, '', 0, 0, 0, 22600, 1, '2017-03-22 14:51:01'),
(6, 0, '228', 1, 0, 0000000012, 0000000034, '', 0, 0, 0, 312500, 1, '2017-04-01 22:46:44'),
(7, 0, '', 2, 0, 0000000010, 0000000035, '', 0, 0, 0, 420000, 1, '2017-04-03 19:01:05'),
(8, 0, '', 2, 0, 0000000010, 0000000035, '', 0, 0, 0, 100000, 1, '2017-04-03 19:05:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaccion_item`
--

CREATE TABLE IF NOT EXISTS `transaccion_item` (
  `id_transaccion_item` int(11) NOT NULL AUTO_INCREMENT,
  `transaccion_id` int(11) NOT NULL,
  `pedido_item_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `valor_unitario` int(11) NOT NULL,
  `iva` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL,
  PRIMARY KEY (`id_transaccion_item`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Volcado de datos para la tabla `transaccion_item`
--

INSERT INTO `transaccion_item` (`id_transaccion_item`, `transaccion_id`, `pedido_item_id`, `producto_id`, `cantidad`, `valor_unitario`, `iva`, `estado_id`) VALUES
(1, 1, 0, 1, 50, 2000, 16, 1),
(2, 1, 0, 2, 22, 30000, 16, 1),
(3, 2, 0, 1, 10, 2500, 16, 1),
(4, 2, 0, 2, 20, 25000, 16, 1),
(5, 3, 0, 2, 20, 30000, 16, 1),
(6, 4, 0, 1, 10, 1500, 16, 1),
(7, 5, 0, 6, 10, 1000, 0, 1),
(8, 5, 0, 7, 15, 800, 0, 1),
(9, 5, 0, 8, 1, 600, 0, 1),
(10, 6, 0, 1, 5, 2500, 0, 1),
(11, 6, 0, 6, 2, 150000, 0, 1),
(12, 7, 0, 12, 100, 4200, 0, 1),
(13, 8, 0, 10, 1, 100000, 0, 1);

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
-- Estructura de tabla para la tabla `unidad_medida`
--

CREATE TABLE IF NOT EXISTS `unidad_medida` (
  `id_unidad_medida` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  `estado_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_unidad_medida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
