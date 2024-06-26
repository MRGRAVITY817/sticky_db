use {
    gluesql_memory_storage::MemoryStorage,
    rustler::{NifStruct, ResourceArc},
    tokio::sync::RwLock,
};

#[derive(NifStruct)]
#[module = "StickyDB.Native.MemoryStorage"]
pub struct ExMemoryStorage {
    pub resource: ResourceArc<ExMemoryStorageResource>,
}

#[rustler::nif(schedule = "DirtyCpu")]
pub fn memory_storage_new() -> ExMemoryStorage {
    ExMemoryStorage {
        resource: ResourceArc::new(ExMemoryStorageResource::new()),
    }
}

pub struct ExMemoryStorageResource {
    pub locked_storage: RwLock<MemoryStorage>,
}

impl ExMemoryStorageResource {
    fn new() -> Self {
        Self {
            locked_storage: RwLock::new(MemoryStorage::default()),
        }
    }
}
