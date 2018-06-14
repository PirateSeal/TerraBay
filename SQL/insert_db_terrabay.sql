DELETE FROM users;
INSERT INTO users (`pseudo`, `firstname`, `name`, `password`,`status`) VALUES ('Feral','Thomas','Cousin','YlhE','admin');
INSERT INTO `users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `password`, `balance`, `status`, `photo_path`) VALUES (NULL, 'aze', 'aze@aze.fr', 'aze', 'aze', '2.5', 'TFdI', '2500.00', 'user', NULL);
DELETE FROM species;
INSERT INTO `species` (`id_specie`, `name`) VALUES ('1', 'felines'), ('2', 'canides');

DELETE FROM articles;
INSERT INTO articles (`id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`) VALUES ('1', '1', 'Chat', '250', '3', '1', 'carnivorous', '3', '0.1', 'red', '2');
INSERT INTO `articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (NULL, '1', '1', 'Chat', '250.00', '3', '1', 'carnivorous', '3.00', '0.10', 'pink', '5', 'available', NULL);
INSERT INTO `articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (NULL, '1', '2', 'Bear', '550.00', '3', '1', 'carnivorous', '3.00', '0.10', 'black', '5', 'available', NULL);
INSERT INTO `articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (NULL, '1', '2', 'Fox', '750.00', '3', '1', 'carnivorous', '3.00', '0.10', 'black', '5', 'available', NULL);
INSERT INTO `discounts` (`id_discount`, `id_article`, `status`, `date_start`, `date_end`, `init_price`, `disc_price`) VALUES (NULL, '1', '0', '2018-06-13 18:00:00', '2018-06-13 19:00:00', '150.00', '200.00');
