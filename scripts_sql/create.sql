
CREATE TABLE avaliar_comentario (
    id_comentario NUMERIC(5) NOT NULL,
    id_usuario    NUMERIC(5) NOT NULL,
    id_post       NUMERIC(5) NOT NULL,
    up_vote       boolean,
    down_vote     boolean
);

ALTER TABLE avaliar_comentario ADD CONSTRAINT pk_avaliar_comentario PRIMARY KEY ( id_comentario,
                                                                                  id_usuario );

CREATE TABLE avaliar_post (
    id_usuario    NUMERIC(5) NOT NULL,
    id_post       NUMERIC(5) NOT NULL,
    up_vote       boolean,
    down_vote   boolean,
    post_favorito boolean
);

ALTER TABLE avaliar_post ADD CONSTRAINT pk_avaliar_post PRIMARY KEY ( id_usuario,
                                                                      id_post );

CREATE TABLE avaliar_resposta (
    id_resposta   NUMERIC(5) NOT NULL,
    id_usuario    NUMERIC(5) NOT NULL,
    id_comentario NUMERIC(5) NOT NULL,
    up_vote       boolean,
    down_vote     boolean
);

ALTER TABLE avaliar_resposta ADD CONSTRAINT pk_avaliar_resposta PRIMARY KEY ( id_resposta,
                                                                              id_usuario );

CREATE TABLE red_comentario (
    id_post         NUMERIC(5) NOT NULL,
    id_comentario   NUMERIC(5) NOT NULL,
    id_usuario      NUMERIC(5) NOT NULL,
    body_comentario VARCHAR(250) NOT NULL
);

ALTER TABLE red_comentario ADD CONSTRAINT pk_red_comentario PRIMARY KEY ( id_comentario,
                                                                          id_post );

CREATE TABLE red_comunidade (
    id_comunidade  NUMERIC(5) NOT NULL,
    nm_comunidade  VARCHAR(60) NOT NULL,
    img_comunidade VARCHAR(60) NOT NULL,
    des_comunidade VARCHAR(500)
);

ALTER TABLE red_comunidade ADD CONSTRAINT pk_red_comunidade PRIMARY KEY ( id_comunidade );

CREATE TABLE red_post (
    id_post       NUMERIC(5) NOT NULL,
    id_usuario    NUMERIC(5) NOT NULL,
    id_comunidade NUMERIC(5) NOT NULL,
    tit_post      VARCHAR(60) NOT NULL,
    body_post     VARCHAR(500) NOT NULL
);

ALTER TABLE red_post ADD CONSTRAINT pk_red_post PRIMARY KEY ( id_post );

CREATE TABLE red_regra_comunidade (
    id_regra      NUMERIC(5) NOT NULL,
    id_comunidade NUMERIC(5) NOT NULL,
    tit_regra     VARCHAR(60) NOT NULL,
    body_regra    VARCHAR(255) NOT NULL
);

ALTER TABLE red_regra_comunidade ADD CONSTRAINT pk_red_regra_comunidade PRIMARY KEY ( id_regra );

CREATE TABLE red_resposta (
    id_comentario  NUMERIC(5) NOT NULL,
    id_resposta    NUMERIC(5) NOT NULL,
    id_post        NUMERIC(5) NOT NULL,
    id_resposta1   NUMERIC(5) NOT NULL,
    id_comentario1 NUMERIC(5) NOT NULL,
    body_resposta  VARCHAR(250) NOT NULL
);

ALTER TABLE red_resposta ADD CONSTRAINT pk_red_resposta PRIMARY KEY ( id_resposta,
                                                                      id_comentario );

CREATE TABLE red_role (
    id_role  NUMERIC(5) NOT NULL,
    nm_role  VARCHAR(60) NOT NULL,
    des_role VARCHAR(250) NOT NULL
);

ALTER TABLE red_role ADD CONSTRAINT pk_red_role PRIMARY KEY ( id_role );

CREATE TABLE red_usuario (
    id_usuario  NUMERIC(5) NOT NULL,
    nm_usuario  VARCHAR(50) NOT NULL,
    img_usuario VARCHAR(60),
    log_usuario VARCHAR(60) NOT NULL,
    sen_cliente VARCHAR(60),
    google_id   VARCHAR(255)
);

ALTER TABLE red_usuario ADD CONSTRAINT pk_red_usuario PRIMARY KEY ( id_usuario );

CREATE TABLE red_usuario_comunidade (
    id_usuario     NUMERIC(5) NOT NULL,
    red_comunidade NUMERIC(5) NOT NULL,
    id_role        NUMERIC(5) NOT NULL
);

ALTER TABLE red_usuario_comunidade ADD CONSTRAINT pk_red_usuario_comunidade PRIMARY KEY ( id_usuario,
                                                                                          red_comunidade );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE avaliar_comentario
    ADD CONSTRAINT fk_avaliar_comentario_comentario FOREIGN KEY ( id_comentario,
                                                                  id_post )
        REFERENCES red_comentario ( id_comentario,
                                    id_post );

ALTER TABLE avaliar_comentario
    ADD CONSTRAINT fk_avaliar_comentario_usuario FOREIGN KEY ( id_usuario )
        REFERENCES red_usuario ( id_usuario );

ALTER TABLE avaliar_post
    ADD CONSTRAINT fk_avaliar_post_post FOREIGN KEY ( id_post )
        REFERENCES red_post ( id_post );

ALTER TABLE avaliar_post
    ADD CONSTRAINT fk_avaliar_post_usuario FOREIGN KEY ( id_usuario )
        REFERENCES red_usuario ( id_usuario );

ALTER TABLE avaliar_resposta
    ADD CONSTRAINT fk_avaliar_resposta_resposta FOREIGN KEY ( id_resposta,
                                                              id_comentario )
        REFERENCES red_resposta ( id_resposta,
                                  id_comentario );

ALTER TABLE avaliar_resposta
    ADD CONSTRAINT fk_avaliar_resposta_usuario FOREIGN KEY ( id_usuario )
        REFERENCES red_usuario ( id_usuario );

ALTER TABLE red_comentario
    ADD CONSTRAINT fk_comentario_post FOREIGN KEY ( id_post )
        REFERENCES red_post ( id_post );

ALTER TABLE red_comentario
    ADD CONSTRAINT fk_comentario_usuario FOREIGN KEY ( id_usuario )
        REFERENCES red_usuario ( id_usuario );

ALTER TABLE red_usuario_comunidade
    ADD CONSTRAINT fk_comunidade_usuario FOREIGN KEY ( id_usuario )
        REFERENCES red_usuario ( id_usuario );

ALTER TABLE red_post
    ADD CONSTRAINT fk_post_comunidade FOREIGN KEY ( id_comunidade )
        REFERENCES red_comunidade ( id_comunidade );

ALTER TABLE red_post
    ADD CONSTRAINT fk_post_usuario FOREIGN KEY ( id_usuario )
        REFERENCES red_usuario ( id_usuario );

ALTER TABLE red_regra_comunidade
    ADD CONSTRAINT fk_regra_comunidade_comunidade FOREIGN KEY ( id_comunidade )
        REFERENCES red_comunidade ( id_comunidade );

ALTER TABLE red_resposta
    ADD CONSTRAINT fk_resposta_comentario1 FOREIGN KEY ( id_comentario,
                                                         id_post )
        REFERENCES red_comentario ( id_comentario,
                                    id_post );

ALTER TABLE red_resposta
    ADD CONSTRAINT fk_resposta_resposta1 FOREIGN KEY ( id_resposta1,
                                                       id_comentario1 )
        REFERENCES red_resposta ( id_resposta,
                                  id_comentario );

ALTER TABLE red_usuario_comunidade
    ADD CONSTRAINT fk_usuario_comunidade FOREIGN KEY ( red_comunidade )
        REFERENCES red_comunidade ( id_comunidade );

ALTER TABLE red_usuario_comunidade
    ADD CONSTRAINT fk_usuario_role FOREIGN KEY ( id_role )
        REFERENCES red_role ( id_role );
