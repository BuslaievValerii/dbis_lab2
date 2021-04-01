/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     01.04.2021 5:04:59                           */
/*==============================================================*/


/*==============================================================*/
/* Table: Participant                                           */
/*==============================================================*/
create table Participant (
   OutId                VARCHAR(64)          not null,
   Birth                INTEGER              null,
   SexTypename          VARCHAR(64)          null,
   RegName              VARCHAR(64)          null,
   AreaName             VARCHAR(128)         null,
   TerName              VARCHAR(128)         null,
   RegTypeName          VARCHAR(128)         null,
   terTypeName          VARCHAR(128)         null,
   ClassProfileName     VARCHAR(128)         null,
   ClassLangName        VARCHAR(128)         null,
   constraint PK_PARTICIPANT primary key (OutId)
);

/*==============================================================*/
/* Index: Participant_PK                                        */
/*==============================================================*/
create unique index Participant_PK on Participant (
OutId
);

/*==============================================================*/
/* Table: ParticipantStudyPlace                                 */
/*==============================================================*/
create table ParticipantStudyPlace (
   OutId                VARCHAR(64)          not null,
   PlaceID              INTEGER              not null,
   constraint PK_PARTICIPANTSTUDYPLACE primary key (OutId, PlaceID)
);

/*==============================================================*/
/* Index: ParticipantStudyPlace_PK                              */
/*==============================================================*/
create unique index ParticipantStudyPlace_PK on ParticipantStudyPlace (
OutId,
PlaceID
);

/*==============================================================*/
/* Table: ParticipantZNOPlace                                   */
/*==============================================================*/
create table ParticipantZNOPlace (
   OutId                VARCHAR(64)          not null,
   PlaceID              INTEGER              not null,
   SubjectID            VARCHAR(4)           not null,
   constraint PK_PARTICIPANTZNOPLACE primary key (OutId, PlaceID, SubjectID)
);

/*==============================================================*/
/* Index: ParticipantZNOPlace_PK                                */
/*==============================================================*/
create unique index ParticipantZNOPlace_PK on ParticipantZNOPlace (
OutId,
PlaceID,
SubjectID
);

/*==============================================================*/
/* Table: Place                                                 */
/*==============================================================*/
create table Place (
   PlaceID              SERIAL               PRIMARY KEY,
   PlaceName            VARCHAR(255)         null,
   PlaceTypeName        VARCHAR(128)         null,
   PlaceRegName         VARCHAR(128)         null,
   PlaceAreaName        VARCHAR(128)         null,
   PlaceTerName         VARCHAR(128)         null,
   PlaceParent          VARCHAR(255)         null
);

/*==============================================================*/
/* Index: Place_PK                                              */
/*==============================================================*/
create unique index Place_PK on Place (
PlaceID
);

/*==============================================================*/
/* Table: Results                                               */
/*==============================================================*/
create table Results (
   OutId                VARCHAR(64)          not null,
   SubjectID            VARCHAR(4)           not null,
   Lang                 VARCHAR(128)         null,
   TestStatus           VARCHAR(128)         null,
   DPALevel             VARCHAR(64)          null,
   Ball100              INTEGER              null,
   Ball12               INTEGER              null,
   Ball                 INTEGER              null,
   AdaptScale           INTEGER              null,
   Year                 INTEGER              null,
   constraint PK_RESULTS primary key (OutId, SubjectID)
);

/*==============================================================*/
/* Index: Results_PK                                            */
/*==============================================================*/
create unique index Results_PK on Results (
OutId,
SubjectID
);

/*==============================================================*/
/* Table: Subjects                                              */
/*==============================================================*/
create table Subjects (
   SubjectID            VARCHAR(4)           not null,
   Description          VARCHAR(64)          null,
   constraint PK_SUBJECTS primary key (SubjectID)
);

/*==============================================================*/
/* Index: Subjects_PK                                           */
/*==============================================================*/
create unique index Subjects_PK on Subjects (
SubjectID
);

alter table ParticipantStudyPlace
   add constraint FK_PARTICIP_PARTICIPA_PARTICIP foreign key (OutId)
      references Participant (OutId)
      on delete restrict on update restrict;

alter table ParticipantStudyPlace
   add constraint FK_PARTICIP_PLACE_IN__PLACE foreign key (PlaceID)
      references Place (PlaceID)
      on delete restrict on update restrict;

alter table ParticipantZNOPlace
   add constraint FK_PARTICIP_PARTICIPA_PARTICIP foreign key (OutId)
      references Participant (OutId)
      on delete restrict on update restrict;

alter table ParticipantZNOPlace
   add constraint FK_PARTICIP_PLACE_IN__PLACE foreign key (PlaceID)
      references Place (PlaceID)
      on delete restrict on update restrict;

alter table ParticipantZNOPlace
   add constraint FK_PARTICIP_SUBJECT_I_SUBJECTS foreign key (SubjectID)
      references Subjects (SubjectID)
      on delete restrict on update restrict;

alter table Results
   add constraint FK_RESULTS_PARTICIPA_PARTICIP foreign key (OutId)
      references Participant (OutId)
      on delete restrict on update restrict;

alter table Results
   add constraint FK_RESULTS_SUBJECT_I_SUBJECTS foreign key (SubjectID)
      references Subjects (SubjectID)
      on delete restrict on update restrict;

