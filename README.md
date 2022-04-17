# Project Zero Code Repository

Project Zero Code Repository: Code shared by the research community for the pzero database.

This repository was created using the structure and content of the [MIMIC Code Repository](https://github.com/MIT-LCP/mimic-code) as areference.

## Brief introduction

The repository consists of a number of Structured Query Language (SQL) scripts which build the Project Zero database in a number of systems and extract useful concepts from the raw data. Subfolders include:

* [build_p_zero](/build_p_zero) - Scripts to build Project Zero in various relational database management system (RDMS), in particular [postgres](/build_p_zero/postgres).
* [concepts](/concepts) - Useful views/summaries of the data in Project Zero, e.g. demographics, organ failure scores, severity of illness scores, durations of treatment, easier to analyze views, etc. The [future paper]() describes these in detail, and a README in the subfolder lists concepts generated.

### Concepts

The [Project Zero concepts](/concepts) are scripts written in PostgreSQL.

## Database structure


