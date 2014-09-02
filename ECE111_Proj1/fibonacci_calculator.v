/* Fibonacci Calculator. Project 1 for ECE 111
 * Name: 	Richard Bull 	&	Max Hughes
 * PID:  	A09309891	&	A09671948
 *
 *
 */

module fibonacci_calculator (input_s, reset_n, begin_fibo, clk, done, fibo_out) ; 
                         input  [4:0] input_s ; 
                         input  reset_n ; 
                         input  begin_fibo ; 
                         input  clk ; 
                         output done ; 
                         output [15:0] fibo_out ;
								 
			//reg q;
			reg [15:0] f1; // F-1
			reg [15:0] f2; // F-2
			reg [4:0] count;
				//reg go;
			wire go;
			
			wire art_clk; // Artifical internal clock
			initial begin
			f1 = 16'd1;
			f2 = 16'd0;
			count = 5'd2;
			end

			
			always @ (posedge art_clk)
			begin
				//go <= (begin_fibo|go)&reset_n;
				/*if (~reset_n)
				begin
					//q = 1'd0;
					f1 = 16'd1;
					f2 = 16'd0;
					count = 5'd2;
			   end
				else
				begin*/
				if (go & ~done)
					begin
						/*if (q)
							f1 <= f1 + f2;
						else
							f2 <= f1 + f2;
						q <= ~q;*/
						f1 <= f1 + f2;
						f2 <= f1;
						count <= count + 5'd1;
						
					end
				else if (~go)
					begin
					f1 <= 16'd1;
					f2 <= 16'd0;
					count <= 5'd2;
					end
				//end
				
			end
			
			assign art_clk = clk^begin_fibo; 
			// We artificially pulse our internal clock when begin_fibo goes high.
			// This eliminates an extra cycle.
			
			
			//assign lat_r = ~(~reset_n|go);
			//assign go = ~(begin_fibo|lat_r);
			assign go = (begin_fibo|go)&reset_n;
			assign done = (count == input_s);
			assign fibo_out = f1+f2;//(input_s == 5'd0)?16'd0:f1+f2;//= q?f1:f2;
endmodule
