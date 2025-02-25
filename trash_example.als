var sig File {}
var sig Trash in File {}

fact init {
  no Trash
}

pred empty {
  some Trash and       // guard
  after no Trash and   // effect on Trash
  File' = File - Trash // effect on File
}

pred delete [f : File] {
  not (f in Trash)   // guard
  Trash' = Trash + f // effect on Trash
  File' = File       // frame condition on File
}

pred restore [f : File] {
  f in Trash         // guard
  Trash' = Trash - f // effect on Trash
  File' = File       // frame condition on File
}

pred permdelete [f : File]{
  f in Trash
  Trash' = Trash - f
  File' = File - f
}


fact trans {
  always (empty or (some f : File | delete[f] or restore[f] or permdelete[f]))
}

run example {} for 5
