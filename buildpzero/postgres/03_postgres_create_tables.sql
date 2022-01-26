-- -------------------------------------------------------------------------------
--
-- Create covidhm tables
--
-- -------------------------------------------------------------------------------

--------------------------------------------------------
--  File created - 19/01/2021
--------------------------------------------------------

-- If running scripts individually, you can set the schema where all tables are created as follows:
SET search_path TO covid_dsl_v2; -- or your schema name

--------------------------------------------------------
--  DDL for Table antibiograma
--------------------------------------------------------

-- Drop table

-- DROP TABLE antibiograma;

CREATE TABLE antibiograma(
   idPeticionClinica INTEGER 
  ,version           INTEGER 
  ,numSpecimen       INTEGER 
  ,idSpecimen        INTEGER 
  ,idnMicro          INT 
  ,idAntiPrueb       VARCHAR
  ,AntiPruebDescr    VARCHAR
  ,AntiResut         VARCHAR
  ,normalidadAnti    VARCHAR
  ,FechaResul        DATE 
  ,HoraResul         VARCHAR
  ,status            VARCHAR
);

--------------------------------------------------------
--  DDL for Table demo
--------------------------------------------------------

-- Drop table

-- DROP TABLE demo;

CREATE TABLE demo(
   idPcnt       INTEGER 
  ,FecNaci      VARCHAR
  ,Sexo         INTEGER 
  ,Nacionalidad VARCHAR
  ,Apellido1    VARCHAR
  ,Apellido2    VARCHAR
  ,Nombre       VARCHAR
  ,CIF          VARCHAR
  ,Direccion    VARCHAR
  ,Tef1         VARCHAR
  ,Tef2         VARCHAR
);

--------------------------------------------------------
--  DDL for Table diatext
--------------------------------------------------------

-- Drop table

-- DROP TABLE diatext;

CREATE TABLE diatext(
   idPcnt     INTEGER 
  ,idEpisodi  INTEGER 
  ,numDiagAct INTEGER 
  ,numMovAct  INT 
  ,Textlibre  VARCHAR
  ,diaDiag    DATE 
  ,horaDiag   VARCHAR
);

--------------------------------------------------------
--  DDL for Table episdi
--------------------------------------------------------

-- Drop table

-- DROP TABLE episdi;

CREATE TABLE episdi(
   idPcnt        INTEGER 
  ,idEpisodi     INTEGER 
  ,IdClasEpisodi INTEGER 
  ,areaSalut     VARCHAR
  ,ulNumMov      INTEGER 
  ,idStatus      VARCHAR
  ,clasEpisodi   VARCHAR
  ,FinEpidia     DATE 
  ,FinEpiHor     VARCHAR
);

--------------------------------------------------------
--  DDL for Table exitus
--------------------------------------------------------

-- Drop table

-- DROP TABLE exitus;

CREATE TABLE exitus(
   idPcnt     INTEGER 
  ,FecExitus  DATE 
  ,HoraExitus VARCHAR
);

--------------------------------------------------------
--  DDL for Table exp
--------------------------------------------------------

-- Drop table

-- DROP TABLE exp;

CREATE TABLE exp(
   idPcnt       INTEGER 
  ,NumPrVital   INTEGER 
  ,IdPrVital    VARCHAR
  ,ValorRC      VARCHAR
  ,UOMedica     VARCHAR
  ,UOInfermeria VARCHAR
  ,FecRC        DATE 
  ,HoraRC       VARCHAR
  ,cenSanitario VARCHAR
  ,ValValor     INTEGER 
  ,Origen       VARCHAR
  ,idMonitor    INTEGER 
  ,USResp       INTEGER 
);

--------------------------------------------------------
--  DDL for Table lab_texto
--------------------------------------------------------

-- Drop table

-- DROP TABLE lab_texto;

CREATE TABLE lab_texto(
   idPeticionClinica VARCHAR
  ,version           INTEGER 
  ,idreflab          VARCHAR
  ,reflabDesc        VARCHAR
  ,resultado         VARCHAR
  ,Unidades          VARCHAR
  ,rangoMuestra      VARCHAR
  ,Normalidad        VARCHAR
  ,FechaResul        DATE 
  ,HoraResul         VARCHAR
  ,tipoResul         VARCHAR
  ,ResTexto          VARCHAR
);

--------------------------------------------------------
--  DDL for Table lab_valor
--------------------------------------------------------

-- Drop table

-- DROP TABLE lab_valor;

CREATE TABLE lab_valor(
   idPeticionClinica VARCHAR
  ,version           INTEGER 
  ,idreflab          VARCHAR
  ,reflabDesc        VARCHAR
  ,resultado         NUMERIC
  ,Unidades          VARCHAR
  ,rangoMuestra      VARCHAR
  ,Normalidad        VARCHAR
  ,FechaResul        DATE 
  ,HoraResul         VARCHAR
  ,tipoResul         VARCHAR
);

--------------------------------------------------------
--  DDL for Table microorg
--------------------------------------------------------

-- Drop table

-- DROP TABLE microorg;

CREATE TABLE microorg(
   idPeticionClinica VARCHAR
  ,version           INTEGER 
  ,nLinea            INTEGER 
  ,numSpecimen       INTEGER 
  ,idSpecimen        INTEGER 
  ,idnMicro          INTEGER 
  ,idMicro           VARCHAR
  ,MicroRes          VARCHAR
  ,MicroPos          VARCHAR
  ,Conc              VARCHAR
  ,ConcDescr         VARCHAR
  ,normalidadMuestra VARCHAR
  ,FechaResul        DATE 
  ,HoraResul         VARCHAR
  ,Prestacion        VARCHAR
  ,Observacion       VARCHAR
  ,status            VARCHAR
);

--------------------------------------------------------
--  DDL for Table movact
--------------------------------------------------------

-- Drop table

-- DROP TABLE movact;

CREATE TABLE movact(
   idPcnt       INTEGER 
  ,idEpisodi    INTEGER 
  ,numDiagAct   INTEGER 
  ,idTipoMov    INTEGER 
  ,idClasMov    VARCHAR
  ,IniDiaMov    DATE 
  ,IniHourMov   VARCHAR
  ,idStatud     INTEGER 
  ,FinDiaMov    DATE 
  ,FinHourMov   VARCHAR
  ,cenSanitario VARCHAR
  ,uoMedica     VARCHAR
  ,uoEpisodio   VARCHAR
  ,idHab        VARCHAR
  ,idCama       VARCHAR
);

--------------------------------------------------------
--  DDL for Table movim
--------------------------------------------------------

-- Drop table

-- DROP TABLE movim;

CREATE TABLE movim(
   idPcnt       INTEGER 
  ,idEpisodi    INTEGER 
  ,numDiagAct   INTEGER 
  ,idTipoMov    INTEGER 
  ,idClasMov    VARCHAR
  ,IniDiaMov    DATE 
  ,IniHourMov   VARCHAR
  ,idStatud     INTEGER 
  ,FinDiaMov    DATE 
  ,FinHourMov   VARCHAR
  ,cenSanitario VARCHAR
  ,uoMedica     VARCHAR
  ,uoEpisodio   VARCHAR
  ,idHab        VARCHAR
  ,idCama       VARCHAR
  ,FinActMov    VARCHAR
);

--------------------------------------------------------
--  DDL for Table movimext
--------------------------------------------------------

-- Drop table

-- DROP TABLE movimext;

CREATE TABLE movimext(
   idPcnt      INTEGER 
  ,idEpisodi   INTEGER 
  ,numDiagAct  INTEGER 
  ,idTipoMov   INTEGER 
  ,idClasMov   VARCHAR
  ,idCenSanExt VARCHAR
);

--------------------------------------------------------
--  DDL for Table movimmot
--------------------------------------------------------

-- Drop table

-- DROP TABLE movimmot;

CREATE TABLE movimmot(
   idPcnt      INTEGER 
  ,idEpisodi   INTEGER 
  ,numDiagAct  INTEGER 
  ,idTipoMov   INTEGER 
  ,idClasMov   VARCHAR
  ,idCenSanExt VARCHAR
);

--------------------------------------------------------
--  DDL for Table movpla
--------------------------------------------------------

-- Drop table

-- DROP TABLE movpla;

CREATE TABLE movpla(
   idPcnt      INTEGER 
  ,idEpisodi   INTEGER 
  ,Planificada VARCHAR
  ,FechaPlan   DATE 
  ,HourPlan    VARCHAR
);

--------------------------------------------------------
--  DDL for Table muestra
--------------------------------------------------------

-- Drop table

-- DROP TABLE muestra;

CREATE TABLE muestra(
   idPcnt            INTEGER 
  ,idEpisodi         INTEGER 
  ,idPeticionClinica VARCHAR
  ,version           INTEGER 
  ,numSpecimen       INTEGER 
  ,idSpecimen        INTEGER 
  ,idTipoMuestra     VARCHAR
  ,DescrMues         VARCHAR
  ,MetodoMues        VARCHAR
  ,TipoDescr         VARCHAR
  ,FechaExtraccion   DATE 
  ,HoraExtraccion    VARCHAR
);

--------------------------------------------------------
--  DDL for Table pronostlet
--------------------------------------------------------

-- Drop table

-- DROP TABLE pronostlet;

CREATE TABLE pronostlet(
   idPcnt            INTEGER 
  ,idEpisodi         INTEGER 
  ,idPeticionClinica VARCHAR
  ,nLinea            INTEGER 
  ,FecActi           DATE 
  ,HorActi           VARCHAR
  ,TipusLet          VARCHAR
  ,nomUSer           VARCHAR
  ,exitus            INTEGER 
);

--------------------------------------------------------
--  DDL for Table rc_temp
--------------------------------------------------------

-- Drop table

-- DROP TABLE rc_temp;

CREATE TABLE rc_temp(
   idPcnt  INTEGER 
  ,idref   VARCHAR
  ,FechaIN DATE 
  ,FechaFi DATE 
);

--------------------------------------------------------
--  DDL for Table rc_texto
--------------------------------------------------------

-- Drop table

-- DROP TABLE rc_texto;

CREATE TABLE rc_texto(
   idPcnt       INTEGER 
  ,NumPrVital   INTEGER 
  ,IdPrVital    VARCHAR
  ,ValorRC      VARCHAR
  ,UOMedica     VARCHAR
  ,UOInfermeria VARCHAR
  ,FecRC        DATE 
  ,HoraRC       VARCHAR
  ,cenSanitario VARCHAR
  ,ValValor     INTEGER 
  ,Origen       VARCHAR
  ,idMonitor    INTEGER 
  ,USResp       INTEGER 
);

--------------------------------------------------------
--  DDL for Table rc_validacion
--------------------------------------------------------

-- Drop table

-- DROP TABLE rc_validacion;

CREATE TABLE rc_validacion(
   idPcnt     INTEGER 
  ,IdPrVital  VARCHAR
  ,FecRC      DATE 
  ,HoraRC     VARCHAR
  ,UsVali     VARCHAR
  ,FecVal     DATE 
  ,HoraVal    VARCHAR
  ,Comentaro1 VARCHAR
  ,Comentaro2 VARCHAR
);

--------------------------------------------------------
--  DDL for Table rc_valor
--------------------------------------------------------

-- Drop table

-- DROP TABLE rc_valor;

CREATE TABLE rc_valor(
   idPcnt       INTEGER 
  ,NumPrVital   INTEGER 
  ,IdPrVital    VARCHAR
  ,ValorRC      INTEGER 
  ,UOMedica     VARCHAR
  ,UOInfermeria VARCHAR
  ,FecRC        DATE 
  ,HoraRC       VARCHAR
  ,cenSanitario VARCHAR
  ,ValValor     INTEGER 
  ,Origen       VARCHAR
  ,idMonitor    INTEGER 
  ,USResp       INTEGER 
);

--------------------------------------------------------
--  DDL for Table trac_admp
--------------------------------------------------------

-- Drop table

-- DROP TABLE trac_admp;

CREATE TABLE trac_admp(
   idPrec       INTEGER 
  ,idDrug       VARCHAR
  ,ClasCom      INTEGER 
  ,Utrac        VARCHAR
  ,idDrugInt    INTEGER 
  ,Dositotal    INTEGER 
  ,UDositotal   VARCHAR
  ,Dosis        NUMERIC(5,2)
  ,UDosis       VARCHAR
  ,cenSanitario VARCHAR
  ,CantPlan     NUMERIC(5,2)
  ,DurAdm       VARCHAR
  ,UDurAdm      VARCHAR
  ,CantAdm      NUMERIC(5,2)
  ,CantForMag   VARCHAR
  ,UCantForMag  VARCHAR
  ,UCantAdm     VARCHAR
);

--------------------------------------------------------
--  DDL for Table trac_prec
--------------------------------------------------------

-- Drop table

-- DROP TABLE trac_prec;

CREATE TABLE trac_prec(
   idPcnt        INTEGER 
  ,idEpisodi     INTEGER 
  ,idPrec        INTEGER 
  ,Status        INTEGER 
  ,DescPresc     VARCHAR
  ,TipoPres      INTEGER 
  ,FrecUso       VARCHAR
  ,EmplResp      INTEGER 
  ,DescrMed      VARCHAR
  ,IniDiaPres    DATE 
  ,FinDiaPres    DATE 
  ,IniHourPres   VARCHAR
  ,FinHourPres   VARCHAR
  ,idViaAdm      INTEGER 
  ,CantDisp      INTEGER 
  ,UCantDisp     VARCHAR
  ,cenSanitario  VARCHAR
  ,UOMedica      VARCHAR
  ,UOInfermeria  VARCHAR
  ,MotiAnu       VARCHAR
  ,ValPre        INTEGER 
  ,DosImm        VARCHAR
  ,ClavCatMed    VARCHAR
  ,ClasEpisodi   INTEGER 
  ,PresPrioInt   INTEGER 
  ,PresIndMedPRN VARCHAR
  ,PresEmpResp   INTEGER 
  ,DurPres       NUMERIC(7,3)
  ,UDurPres      VARCHAR
  ,idFarm        INTEGER 
  ,UtilPres      INTEGER 
  ,MotUtil       VARCHAR
);

--------------------------------------------------------
--  DDL for Table tracdic
--------------------------------------------------------

-- Drop table

-- DROP TABLE tracdic;

CREATE TABLE tracdic(
   idDrug     VARCHAR
  ,NomSAP     VARCHAR
  ,Grup       VARCHAR
  ,SubGrup    VARCHAR
  ,NomSubGrup VARCHAR
  ,Prioridad  INTEGER 
);
