alter table campaign add column free_text text;

alter table campaign add column objective text not null;

alter table campaign add column project_id integer references project(id);

