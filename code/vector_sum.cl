kernel void sum(global float *a, 
                global float *b,
                global float *c){
  int gid = get_global_id(0);
  c[gid] = a[gid] + b[gid];
}

kernel void sum_batched(global float *a, 
                        global float *b,
                        global float *c){
  int gid = get_global_id(0)*BATCH_SIZE;
    
  for(int i=0; i<BATCH_SIZE;++i)
     c[gid + i] = a[gid + i] + b[gid + i];
}

kernel void sum16(global float16 *a, 
                  global float16 *b,
                  global float16 *c){
  int gid = get_global_id(0);
    
  c[gid] = a[gid] + b[gid];
}

kernel void sum_batched_private(global float *a, 
                                global float *b,
                                global float *c){
  int gid = get_global_id(0)*BATCH_SIZE;
    
  float a_tmp[BATCH_SIZE];
  float b_tmp[BATCH_SIZE];
  float c_tmp[BATCH_SIZE];
      
  for(int i=0; i<BATCH_SIZE;++i){
    a_tmp[i] = a[gid + i];
    b_tmp[i] = b[gid + i];
  }
    
  for(int i=0; i<BATCH_SIZE;++i)
    c_tmp[i] = a_tmp[i] + b_tmp[i];
    
  for(int i=0; i<BATCH_SIZE;++i) c[gid + i] = c_tmp[i];
}

kernel void sum16_local(global float16 *a, 
                        global float16 *b,
                        global float16 *c){
  int wid = get_group_id(0)*WG_SIZE;
  int lid = get_local_id(0);
    
  // Local memories
  local float16 a_local[WG_SIZE];
  local float16 b_local[WG_SIZE];
  local float16 c_local[WG_SIZE];
    
  // Copying on
  event_t copyon[2];
  copyon[0] = async_work_group_copy(a_local, a + wid, WG_SIZE, 0);
  copyon[1] = async_work_group_copy(b_local, b + wid, WG_SIZE, 0);
  wait_group_events(2, copyon);
    
  c_local[lid] = a_local[lid] + b_local[lid];
    
  // Copying off
  event_t copyoff[1];
  copyoff[0] = async_work_group_copy(c + wid, c_local, WG_SIZE, 0);
  wait_group_events(1, copyoff);
}