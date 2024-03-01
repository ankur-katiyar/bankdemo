//ZBNKINIT  JOB ZBNKINIT,MFIDEMO,CLASS=A,MSGCLASS=X,NOTIFY=MFIDEMO
//* ******************************************************************
//* ZBNKINIT.JCL
//* ******************************************************************
//* DELETE AND DEFINE VSAM FILES REQUIRED IF USING CICS
//* ******************************************************************
//* STEP01 - DELETE VSAM FILES
//* ******************************************************************
//STEP01   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DELETE MFI01V.MFIDEMO.BNKACC
  DELETE MFI01V.MFIDEMO.BNKATYPE
  DELETE MFI01V.MFIDEMO.BNKCUST
  DELETE MFI01V.MFIDEMO.BNKTXN
  DELETE MFI01V.MFIDEMO.BNKHELP
  SET    MAXCC=0
//* ******************************************************************
//* STEP02 - DEFINE VSAM FILES
//* ******************************************************************
//STEP02   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DEFINE CLUSTER (NAME(MFI01V.MFIDEMO.BNKACC)       -
                  TRACKS(5 1)                          -
                  VOLUMES(MRNT04)                      -
                  KEYS(9 5)                            -
                  RECSZ(200 200)                       -
                  INDEXED)                             -
         DATA    (NAME(MFI01V.MFIDEMO.BNKACC.DAT)   -
                  CISZ(8192))                          -
         INDEX   (NAME(MFI01V.MFIDEMO.BNKACC.IDX)) 
  DEFINE CLUSTER (NAME(MFI01V.MFIDEMO.BNKATYPE)     -
                  TRACKS(5 1)                          -
                  VOLUMES(MRNT04)                      -
                  KEYS(1 0)                            -
                  RECSZ(100 100)                       -
                  INDEXED)                             -
         DATA    (NAME(MFI01V.MFIDEMO.BNKATYPE.DAT) -
                  CISZ(8192))                          -
         INDEX   (NAME(MFI01V.MFIDEMO.BNKATYPE.IDX))
  DEFINE CLUSTER (NAME(MFI01V.MFIDEMO.BNKCUST)      -
                  TRACKS(5 1)                          -
                  VOLUMES(MRNT04)                      -
                  KEYS(5 0)                            -
                  RECSZ(250 250)                       -
                  INDEXED)                             -
         DATA    (NAME(MFI01V.MFIDEMO.BNKCUST.DAT)  -
                  CISZ(8192))                          -
         INDEX   (NAME(MFI01V.MFIDEMO.BNKCUST.IDX))

  DEFINE CLUSTER (NAME(MFI01V.MFIDEMO.BNKTXN)       -
                  TRACKS(5 1)                          -
                  VOLUMES(MRNT04)                      -
                  KEYS(26 16)                          -
                  RECSZ(400 400)                       -
                  INDEXED)                             -
         DATA    (NAME(MFI01V.MFIDEMO.BNKTXN.DAT)   -
                  CISZ(8192))                          -
         INDEX   (NAME(MFI01V.MFIDEMO.BNKTXN.IDX))
  DEFINE CLUSTER (NAME(MFI01V.MFIDEMO.BNKHELP)      -
                  TRACKS(5 1)                          -
                  VOLUMES(MRNT04)                      -
                  KEYS(8 0)                            -
                  RECSZ(83 83)                         -
                  INDEXED)                             -
         DATA    (NAME(MFI01V.MFIDEMO.BNKHELP.DAT)  -
                  CISZ(8192))                          -
         INDEX   (NAME(MFI01V.MFIDEMO.BNKHELP.IDX))
  SET MAXCC=0
//* ******************************************************************
//* STEP03 - DEFINE ALTERNATE INDEXS AND PATH S
//* ******************************************************************
//STEP03   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DEFINE AIX     (NAME(MFI01V.MFIDEMO.BNKACC.AIX1)  -
                  TRACKS(5 1)                          -
                  VOLUMES(MRNT04)                      -
                  RELATE(MFI01V.MFIDEMO.BNKACC)     -
                  KEYS(5 0))
  DEFINE AIX     (NAME(MFI01V.MFIDEMO.BNKCUST.AIX1) -
                  TRACKS(5 1)                          -
                  VOLUMES(MRNT04)                      -
                  RELATE(MFI01V.MFIDEMO.BNKCUST)    -
                  KEYS(25 5))
  DEFINE AIX     (NAME(MFI01V.MFIDEMO.BNKCUST.AIX2) -
                  TRACKS(5 1)                          -
                  VOLUMES(MRNT04)                      -
                  RELATE(MFI01V.MFIDEMO.BNKCUST)    -
                  KEYS(25 30))
  DEFINE AIX     (NAME(MFI01V.MFIDEMO.BNKTXN.AIX1)  -
                  TRACKS(5 1)                          -
                  VOLUMES(MRNT04)                      -
                  RELATE(MFI01V.MFIDEMO.BNKTXN)     -
                  KEYS(35 7))

     DEFINE PATH (NAME(MFI01V.MFIDEMO.BNKACC.PATH1) -
                  PENT(MFI01V.MFIDEMO.BNKACC.AIX1))
     DEFINE PATH (NAME(MFI01V.MFIDEMO.BNKCUST.PATH1)-
                  PENT(MFI01V.MFIDEMO.BNKCUST.AIX1))
     DEFINE PATH (NAME(MFI01V.MFIDEMO.BNKCUST.PATH2)-
                  PENT(MFI01V.MFIDEMO.BNKCUST.AIX2))
     DEFINE PATH (NAME(MFI01V.MFIDEMO.BNKTXN.PATH1) -
                  PENT(MFI01V.MFIDEMO.BNKTXN.AIX1))

  LISTC  LVL     (MFI01V.MFIDEMO)
  SET MAXCC=0
/*