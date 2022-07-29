create database pratica_integridade;

create table states (
	id serial primary key,
	name text not null
);

create table cities (
	id serial primary key,
	name text not null,
	"stateId" integer not null references "states"("id")
);

create table customers (
	id serial primary key,
	"fullName" text not null,
	cpf varchar(11) not null unique,
	email text not null unique,
	password text not null
);

create type type_phone as enum ('landline', 'mobile');

create table "customerPhone" (
	id serial primary key,
	"customerId" integer not null references "customers"("id"),
	number text not null,
	type type_phone
);

create table "customerAddresses" (
	id serial primary key,
	"customerId" integer not null unique references "customers"("id"),
	street text not null,
	number integer not null,
	complement text default null,
	"postalCode" text not null,
	"cityId" integer not null references "cities"("id")
);

create table "bankAccount" (
	id serial primary key,
	"customerId" integer not null unique references "customers"("id"),
	"accountNumber" text not null unique,
	agency text not null,
	"openDate" date not null default now(),
	"closeDate" date
);

create type type_transaction as enum ('deposit', 'withdraw');

create table transactions (
	id serial primary key,
	"bankAccountId" integer not null unique references "bankAccount"("id"),
	amount integer not null default 0,
	type type_transaction,
	time timestamp not null default now(),
	description text,
	cancelled boolean not null default false
);

create table "creditCard" (
	id serial primary key,
	"bankAccountId" integer not null unique references "bankAccount"("id"),
	name text not null,
	number text not null,
	"securityCode" varchar(3) not null,
	"expirationMonth" integer not null,
	"expirationYear" integer not null,
	password text not null,
	"limit" integer not null
);

	
