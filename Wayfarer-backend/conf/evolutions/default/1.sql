# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table way_user (
  id                        bigint not null,
  email                     varchar(255),
  fullname                  varchar(255),
  is_admin                  boolean,
  constraint pk_way_user primary key (id))
;

create sequence way_user_seq;




# --- !Downs

drop table if exists way_user cascade;

drop sequence if exists way_user_seq;

