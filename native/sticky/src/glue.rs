use {
    crate::{
        payload::convert_payloads,
        result::{parse_sql, translate_sql_statement, ExResult},
        storages::{execute_query, plan_query, ExStorage},
    },
    gluesql_core::prelude::Payload,
    rustler::NifStruct,
};

#[derive(NifStruct)]
#[module = "StickyDB.Native.Glue"]
pub struct ExGlue {
    pub storage: ExStorage,
}

#[rustler::nif(schedule = "DirtyCpu")]
pub fn glue_new(storage: ExStorage) -> ExGlue {
    ExGlue { storage }
}

#[rustler::nif(schedule = "DirtyCpu")]
pub fn glue_query(glue: ExGlue, sql: String) -> ExResult<Vec<String>> {
    let mut storage = glue.storage;

    parse_sql(sql)?
        .iter()
        .map(|statement| {
            translate_sql_statement(statement)
                .and_then(|st| plan_query(&storage, st))
                .and_then(|st| execute_query(&mut storage, st))
        })
        .collect::<ExResult<Vec<Payload>>>()
        .map(convert_payloads)
}
