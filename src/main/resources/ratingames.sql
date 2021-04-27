-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-04-2021 a las 15:21:26
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ratingames`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id`, `userId`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `discussion`
--

CREATE TABLE `discussion` (
  `id` int(11) NOT NULL,
  `gameId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `subject` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `discussion`
--

INSERT INTO `discussion` (`id`, `gameId`, `userId`, `subject`) VALUES
(1, 1, 2, '¿De qué sirve buscar todas las semillas de Kolog?');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `game`
--

CREATE TABLE `game` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `studio` varchar(50) NOT NULL,
  `players` varchar(40) NOT NULL,
  `releaseDate` date NOT NULL,
  `language` varchar(20) NOT NULL,
  `minimumAge` int(11) DEFAULT NULL,
  `platformId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `game`
--

INSERT INTO `game` (`id`, `title`, `studio`, `players`, `releaseDate`, `language`, `minimumAge`, `platformId`) VALUES
(1, 'The Legend of Zelda: Breath of the Wild', 'Nintendo EPD', 'Un jugador', '2017-03-03', 'JA,EN,ES,IT,FR,DE,RU', 12, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gamegenre`
--

CREATE TABLE `gamegenre` (
  `gameId` int(11) NOT NULL,
  `genreId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `gamegenre`
--

INSERT INTO `gamegenre` (`gameId`, `genreId`) VALUES
(1, 2),
(1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genre`
--

CREATE TABLE `genre` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `genre`
--

INSERT INTO `genre` (`id`, `name`) VALUES
(1, 'Shooter'),
(2, 'Aventura'),
(3, 'Acción'),
(4, 'Plataformas'),
(5, 'Horror'),
(6, 'Supervivencia'),
(7, 'Deportes'),
(8, 'Estrategia'),
(9, 'MOBA'),
(10, 'Simulación'),
(11, 'Puzles'),
(12, 'Juego de fiesta'),
(13, 'RPG'),
(14, 'Carreras'),
(15, 'Lucha');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `journalist`
--

CREATE TABLE `journalist` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `message`
--

CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `discussionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `body` text NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `message`
--

INSERT INTO `message` (`id`, `discussionId`, `userId`, `body`, `date`) VALUES
(1, 1, 2, 'He buscado por todas partes, y ya tengo unas 440. Sé que hay unas 900, pero ya solo puedo aumentar mi inventario una vez más. ¿Tiene alguna utilidad buscar las otras 500?', '2021-04-27 12:14:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `new`
--

CREATE TABLE `new` (
  `id` int(11) NOT NULL,
  `journalistId` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `body` text NOT NULL,
  `image` blob NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `platform`
--

CREATE TABLE `platform` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `platform`
--

INSERT INTO `platform` (`id`, `name`) VALUES
(1, 'PC'),
(2, 'XBox Series'),
(3, 'Playstation 5'),
(4, 'Nintendo Switch'),
(5, 'Android'),
(6, 'IOS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `player`
--

CREATE TABLE `player` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `player`
--

INSERT INTO `player` (`id`, `userId`) VALUES
(1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rating`
--

CREATE TABLE `rating` (
  `gameId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `message` text NOT NULL,
  `ratingType` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `rating`
--

INSERT INTO `rating` (`gameId`, `userId`, `rating`, `message`, `ratingType`) VALUES
(1, 2, 10, 'Ningún juego es perfecto, pero Breath of the Wild es algo bastante parecido. \r\nLa historia del juego, aunque algo oculta en las fotos y los flashback, resulta lo bastante interesante para tenernos atados a la silla durante todas las cinemáticas mientras disfrutamos de lo realmente importante, el mundo abierto.\r\n\r\nEl Hyrule devastado ha acabado siendo el mundo más vivo de la saga, si no el más vivo de toda la industria. La variedad de ecosistemas, las ciudades, los restos de la antigua guerra, los asentamientos de monstruos, los santuarios en todas partes, los lugares míticos de la saga... el mundo está lleno de cosas que ver y de misiones que realizar, y nunca se siente vacío. La música de estos lugares ayuda a reforzar esa sensación de estar viendo un mundo antaño lleno de vida, ahora decaído y sufriendo para mantenerse en pie.\r\n\r\nPor otro lado, las mecánicas se centran en aportar el enfoque de supervivencia al juego. La rotura de las armas, la cocina, los ambientes fríos y cálidos, todo suma de manera magistral para conocer el mundo de Hyrule y adaptarte a él. El perder tus armas es una mecánica incómoda y que no gustó a algunos, pero hacerte a esa mecánica te fuerza a integrarte con el mundo y a entenderlo.\r\n\r\nPor último, sus gráficos dieron una muy buena primera impresión de las capacidades de la Nintendo Switch, cumpliendo como juego inicial y como \"vendeconsolas\".\r\n\r\nZelda enseñó en los 90 cómo debían ser los mundos en 3D, y en 2017 enseñó cómo deben ser los mundos abiertos.', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_spanish_ci NOT NULL,
  `password` varchar(30) COLLATE utf8mb4_spanish_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `email`) VALUES
(1, 'admin', 'admin', 'admin@ratingames.es'),
(2, 'jeremy', 'jeremy', 'jeremy.trujillo101@alu.ulpgc.es');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_user_id_fk` (`userId`);

--
-- Indices de la tabla `discussion`
--
ALTER TABLE `discussion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discussion_game_id_fk` (`gameId`),
  ADD KEY `discussion_user_id_fk` (`userId`);

--
-- Indices de la tabla `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`id`),
  ADD KEY `game_platform_id_fk` (`platformId`);

--
-- Indices de la tabla `gamegenre`
--
ALTER TABLE `gamegenre`
  ADD PRIMARY KEY (`gameId`,`genreId`),
  ADD KEY `gamegenre_genre_id_fk` (`genreId`);

--
-- Indices de la tabla `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `journalist`
--
ALTER TABLE `journalist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `journalist_user_id_fk` (`userId`);

--
-- Indices de la tabla `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_discussion_id_fk` (`discussionId`),
  ADD KEY `message_user_id_fk` (`userId`);

--
-- Indices de la tabla `new`
--
ALTER TABLE `new`
  ADD PRIMARY KEY (`id`),
  ADD KEY `new_journalist_id_fk` (`journalistId`);

--
-- Indices de la tabla `platform`
--
ALTER TABLE `platform`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_user_id_fk` (`userId`);

--
-- Indices de la tabla `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`gameId`,`userId`),
  ADD KEY `rating_user_id_fk` (`userId`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_USERNAME` (`username`),
  ADD UNIQUE KEY `UNIQUE_EMAIL` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `discussion`
--
ALTER TABLE `discussion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `game`
--
ALTER TABLE `game`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `genre`
--
ALTER TABLE `genre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `journalist`
--
ALTER TABLE `journalist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `new`
--
ALTER TABLE `new`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `platform`
--
ALTER TABLE `platform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `player`
--
ALTER TABLE `player`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `discussion`
--
ALTER TABLE `discussion`
  ADD CONSTRAINT `discussion_game_id_fk` FOREIGN KEY (`gameId`) REFERENCES `game` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `discussion_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `game`
--
ALTER TABLE `game`
  ADD CONSTRAINT `game_platform_id_fk` FOREIGN KEY (`platformId`) REFERENCES `platform` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `gamegenre`
--
ALTER TABLE `gamegenre`
  ADD CONSTRAINT `gamegenre_game_id_fk` FOREIGN KEY (`gameId`) REFERENCES `game` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `gamegenre_genre_id_fk` FOREIGN KEY (`genreId`) REFERENCES `genre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `journalist`
--
ALTER TABLE `journalist`
  ADD CONSTRAINT `journalist_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_discussion_id_fk` FOREIGN KEY (`discussionId`) REFERENCES `discussion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `message_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `new`
--
ALTER TABLE `new`
  ADD CONSTRAINT `new_journalist_id_fk` FOREIGN KEY (`journalistId`) REFERENCES `journalist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `player`
--
ALTER TABLE `player`
  ADD CONSTRAINT `player_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_game_id_fk` FOREIGN KEY (`gameId`) REFERENCES `game` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rating_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
