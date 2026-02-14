export type EventModule = {
    Source: any,
    EventFunctions: {
        ()->any
    },
    Connection: RBXScriptConnection,
    
    Activate: (func: (any)->any) -> (),
    Load: (remoteEvent: RemoteEvent) -> (),
    Unload: () -> (),
    
    AddFunction: (func: ()->any) -> (),
    RemoveFunction: (func: ()->any) -> (),
    RemoveAllFunctions: () -> ()
}

return {}