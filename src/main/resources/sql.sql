ALTER TABLE tb_user_role DROP FOREIGN KEY tb_user_role_tb_user_id_fk;
ALTER TABLE tb_user_role DROP FOREIGN KEY tb_user_role_tb_role_id_fk;
ALTER TABLE tb_role_permission  DROP FOREIGN KEY tb_role_permission_tb_role_id_fk;
ALTER TABLE tb_role_permission  DROP FOREIGN KEY tb_role_permission_tb_permission_id_fk;

DROP TABLE tb_user;
DROP TABLE tb_role;
DROP TABLE tb_permission;
DROP TABLE tb_user_role;
DROP TABLE tb_role_permission;

#用户表
CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `salt` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `sex` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

# 角色表
CREATE TABLE `tb_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '角色名',
  `available` int(1) NOT NULL DEFAULT '1' COMMENT '是否可用 1可用 0禁用',
  `delete` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除 1删除 0显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

# 权限表
CREATE TABLE `tb_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '权限名',
  `type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '权限类型 菜单menu 或单条权限permission',
  `url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '权限URL',
  `percode` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '权限代码',
  `parentid` int(11) DEFAULT NULL COMMENT '父级ID',
  `available` int(1) DEFAULT '1' COMMENT '是否可用 1可用 0禁用',
  `delete` int(1) DEFAULT '0' COMMENT '是否删除 1删除 0显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

#用户 角色关联表
CREATE TABLE `tb_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  `roleid` int(11) DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

#角色 权限关联表
CREATE TABLE `tb_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) DEFAULT NULL COMMENT '角色id',
  `perid` int(11) DEFAULT NULL COMMENT '权限id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


ALTER TABLE tb_user_role
  ADD CONSTRAINT tb_user_role_tb_user_id_fk
FOREIGN KEY (userid) REFERENCES tb_user (id) ON DELETE SET NULL ON UPDATE SET NULL;

ALTER TABLE tb_user_role
  ADD CONSTRAINT tb_user_role_tb_role_id_fk
FOREIGN KEY (roleid) REFERENCES tb_role (id) ON DELETE SET NULL ON UPDATE SET NULL;

ALTER TABLE tb_role_permission
  ADD CONSTRAINT tb_role_permission_tb_role_id_fk
FOREIGN KEY (roleid) REFERENCES tb_role (id) ON DELETE SET NULL ON UPDATE SET NULL;

ALTER TABLE tb_role_permission
  ADD CONSTRAINT tb_role_permission_tb_permission_id_fk
FOREIGN KEY (perid) REFERENCES tb_permission (id) ON DELETE SET NULL ON UPDATE SET NULL;

CREATE UNIQUE INDEX tb_user_username_uindex ON tb_user (username);

INSERT INTO `tb_user`(`id`, `username`, `password`, `salt`, `phone`, `email`) VALUES (1, 'admin', '859b370c093563f0cd454f2d01fbd161', 'q18idc.com', '13800138000', 'admin@q18idc.com');

INSERT INTO `tb_role`(`id`, `name`, `available`, `delete`) VALUES (1, '超级管理员', 1, 0);

INSERT INTO `tb_user_role`(`id`, `userid`, `roleid`) VALUES (1, 1, 1);

INSERT INTO `tb_permission`(`id`, `name`, `type`, `url`, `percode`, `parentid`, `available`, `delete`) VALUES (1, '用户管理', 'menu', '/', NULL, NULL, 1, 0);
INSERT INTO `tb_permission`(`id`, `name`, `type`, `url`, `percode`, `parentid`, `available`, `delete`) VALUES (2, '用户列表', 'menu', '/admin/user/list.html', NULL, 1, 1, 0);
INSERT INTO `tb_permission`(`id`, `name`, `type`, `url`, `percode`, `parentid`, `available`, `delete`) VALUES (3, '用户列表', 'permission', '/admin/user/list.html', 'user:list', NULL, 1, 0);
INSERT INTO `tb_permission`(`id`, `name`, `type`, `url`, `percode`, `parentid`, `available`, `delete`) VALUES (4, '禁用用户', 'menu', '/admin/user/disables.html', NULL, 1, 1, 0);

INSERT INTO `tb_role_permission`(`id`, `roleid`, `perid`) VALUES (1, 1, 1);
INSERT INTO `tb_role_permission`(`id`, `roleid`, `perid`) VALUES (2, 1, 2);
INSERT INTO `tb_role_permission`(`id`, `roleid`, `perid`) VALUES (3, 1, 3);
INSERT INTO `tb_role_permission`(`id`, `roleid`, `perid`) VALUES (4, 1, 4);

