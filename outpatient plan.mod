/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Administrator
 * Creation Date: 2021年8月26日 at 上午10:37:03
 *********************************************/
int Ntotal_doctor = ...;
int Nhigh_doctor = ...;
int Nlow_doctor = ...;
int Ntotal_patient = ...;

range total_doctor = 1..Ntotal_doctor;
range high_doctor = 1..Nhigh_doctor;
range low_doctor = Nhigh_doctor + 1..Nhigh_doctor + Nlow_doctor;
range total_patient = 1..Ntotal_patient;

int work_time[total_doctor] = ...;
int doctor_init[total_doctor][total_patient];

int first_time = ...;
int second_time = ...;

int each_doctor_patient[total_doctor] = ...;
//每个医生调整后的工作时间

int patient[total_patient][1..2];

dvar int ans;
dvar int npp[total_doctor];
dvar int doctor_time[total_doctor];

int cnt;

execute {
  cnt = 0;
    for(i in total_doctor) {
      for(j in total_patient) {
      if(j > cnt && j <= cnt + each_doctor_patient[i]){
        doctor_init[i][j] = 1;
      }
      else doctor_init[i][j] = 0;
    }
    cnt += each_doctor_patient[i];
  }
}

minimize (ans);

subject to {
  forall(i in total_doctor) {
    //(sum(j in total_patient) first_time * doctor_init[i][j] + sum(j in total_patient) second_time * (doctor_init[i][j] + npp[i][j])) <= work_time[i];
    //(sum(j in total_patient) first_time * doctor_init[i][j] + sum(j in total_patient) second_time * (doctor_init[i][j] + npp[i][j])) <= ans;
     // (sum(j in total_patient) (first_time+second_time) * doctor_init[i][j] + second_time * ( npp[i])) <= work_time[i];
      //(sum(j in total_patient) (first_time+second_time) * doctor_init[i][j] + second_time * ( npp[i])) <= ans;
    if(i in high_doctor && each_doctor_patient[i]>Ntotal_patient/Ntotal_doctor)
   { 
   (sum(j in total_patient) (first_time+second_time) * doctor_init[i][j] +  first_time * (npp[i])) <= ans;
   (sum(j in total_patient) (first_time+second_time) * doctor_init[i][j] +  first_time * (npp[i])) <= work_time[i];
}  
  if(i in low_doctor && each_doctor_patient[i]<Ntotal_patient/Ntotal_doctor)
   {
      
   (sum(j in total_patient) (first_time+second_time) * doctor_init[i][j] +  first_time * (npp[i])) <= ans;
   (sum(j in total_patient) (first_time+second_time) * doctor_init[i][j] +  first_time * (npp[i])) <= work_time[i];
} 
  }
  forall(i in high_doctor) {
    //forall(j in total_patient) {
      //if(doctor_init[i][j] == 1) -1 <= npp[i][j] <= 0;
      //else npp[i][j] == 0;
      
    //} 
    if(each_doctor_patient[i]<Ntotal_patient/Ntotal_doctor)
     npp[i]==0;
      else
  {
    
  npp[i] <= 0;
  npp[i] >=-each_doctor_patient[i];
} 
  }
  forall(i in low_doctor) {
    //forall(j in total_patient) {
     // if(doctor_init[i][j] == 1) npp[i][j] == 0;
      //else 0 <= npp[i][j] <= 1;
      
     if(each_doctor_patient[i]>Ntotal_patient/Ntotal_doctor)
      npp[i]==0;
      else
      npp[i]>= 0;
    } 
  
  
    sum(i in total_doctor) npp[i] == 0;

}
/*execute {
  cnt = 0;
  for(i in total_doctor) {
    for(j in total_patient) {
    writeln( "the doctorintnt");
      writeln( doctor_init[i][j]);
    }
    cnt += each_doctor_patient[i];
  }
}
*/
execute {
  for(i in total_doctor) {
    writeln(npp[i]);
  }
}  
