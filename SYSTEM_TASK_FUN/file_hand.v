module tb;
	integer i,file,file2;
	reg [50*8-1:0]str;
	event e1,e2;
	reg flag;
	initial begin
		file=$fopen("output.log","w");
		$fdisplay(file,"%0t:ENTRY-1",$time);   //0ns
		#5;
		$fdisplay(file,"%0t:ENTRY-2",$time);   //5ns
		#1 $fdisplay(file,"%0t:ENTRY-3",$time); //6ns
		fork:A //6ns                                    all the 10 process starts at 6ns
			#1 $fdisplay(file,"%0t:ENTRY-4",$time);  	//1   7ns			
			begin   						  	//2		//6ns
				#1; 
				$fdisplay(file,"%0t:ENTRY-5",$time);  		//7ns			
			end
         	#30;								//3		//30+6  ->36
			begin 								//4		//6ns
				#10 $fdisplay(file,"%0t:ENTRY-6",$time);      //16ns
				#1;                                     
				#5 $fdisplay(file,"%0t: ENTRY-7",$time);      //22ns
			end 
			#1 $fdisplay(file,"%0t:ENTRY-8",$time);   //5		//7ns
			$fdisplay(file,"%0t:ENTRY-9",$time);   	//6		//6ns
			#10;  								//7		//6ns  
			fork:B 								//6ns
				#1 $fdisplay(file,"%0t:ENTRY_B-1",$time);  // 7ns  	
				$fdisplay(file,"%0t:ENTRY_B-2",$time);      //6ns
				#10;  									
				fork:C 		//6ns
					#1 $fdisplay(file,"%0t:ENTRY_C-1",$time);  //7ns			
					begin   									//6ns
						#1; 
						$fdisplay(file,"%0t:ENTRY_C-2",$time); 	//7ns		
					end
         			#30;										//30+6  ->36
					fork:D //6ns
						#1 $fdisplay(file,"%0t:ENTRY_D-1",$time);  	//7ns		
						begin   									//6ns
							#1; 
							$fdisplay(file,"%0t:ENTRY_D-2",$time); 		//7ns	
						end
         				#30;										//30+6  ->36
						begin 										//6ns
							#10 $fdisplay(file,"%0t:ENTRY_D-3",$time);    //16ns
							#1;                                     
							#5 $fdisplay(file,"%0t: ENTRY_D-4",$time);      //22ns
						end 
						#1 $fdisplay(file,"%0t:ENTRY_D-5",$time);   		//7ns
						$fdisplay(file,"%0t:ENTRY_D-6",$time);   			//6ns
						#10;  										//6ns  
					join:D //36ns
					begin 										//6ns
						#10 $fdisplay(file,"%0t:ENTRY_C-3",$time);    //16ns
						#1;                                     
						#5 $fdisplay(file,"%0t: ENTRY_C-4",$time);     //22ns 
					end 
					#1 $fdisplay(file,"%0t:ENTRY_C-5",$time);   		//7ns
					$fdisplay(file,"%0t:ENTRY_C-6",$time);   			//6ns
					#10;  										//6ns  
				join:C  
				begin  	//6ns								
					#10 $fdisplay(file,"%0t:ENTRY_B-3",$time); //16ns
					#1;                                     
					#5 $fdisplay(file,"%0t: ENTRY_B-4",$time);  //22ns
				end
			join:B//6ns
			$fdisplay(file,"%0t:ENTRY-10",$time);   	//6		//
			#1;                              	//10		//6ns  
			#20 $fdisplay(file,"%0t:ENTRY-11",$time); //26	//
			begin	 							//6ns  
				$fdisplay(file,"%0t:ENTRY-12",$time);         //6     
				$fdisplay(file,"%0t:ENTRY-13",$time);         // 6    
				#1;
				$fdisplay(file,"%0t:ENTRY-14",$time);         //  7   
              	#26 $fdisplay(file,"%0t:ENTRY-15",$time);     //  33  ->33
			end
		join:A //36
		$fdisplay(file,"%0t",$time);
		#1;
		$fdisplay(file,"%0t:ENTRY-16",$time);   //37
		#10 $fdisplay(file,"%0t:ENTRY-17",$time); //47
		$fclose(file);
	end
	initial begin
		file2=$fopen("output1.log","r");
		//while (!$feof(file2)) begin
		while (!$fgets(str,file2)==0)begin
			$display("Time=%0t,str=%0s",$time,str);
		end
		$fclose(file2);
	end
endmodule





/*
# 0:ENTRY-1
# 5:ENTRY-2
# 6:ENTRY-3
# 6:ENTRY-9
# 6:ENTRY_B-2
# 6:ENTRY_D-6
# 6:ENTRY_C-6
# 6:ENTRY-10
# 6:ENTRY-12
# 6:ENTRY-13
# 7:ENTRY-4
# 7:ENTRY-8
# 7:ENTRY-5
# 7:ENTRY_B-1
# 7:ENTRY_C-1
# 7:ENTRY_C-5
# 7:ENTRY_C-2
# 7:ENTRY_D-1
# 7:ENTRY_D-5
# 7:ENTRY_D-2
# 7:ENTRY-14
# 16:ENTRY-6
# 16:ENTRY_D-3
# 16:ENTRY_C-3
# 16:ENTRY_B-3
# 22: ENTRY-7
# 22: ENTRY_D-4
# 22: ENTRY_C-4
# 22: ENTRY_B-4
# 26:ENTRY-11
# 33:ENTRY-15
# 37:ENTRY-16
# 47:ENTRY-17
*/
