module MusicSheet
(
    input [1:0] number,
	output reg [19:0] note,        //max 32 different musical notes
	output reg [4:0] duration,
	output reg done
);
    parameter   QUARTER = 5'b00010; //2 Hz
    parameter	HALF = 5'b00100;
    parameter	ONE = 2* HALF;
    parameter	TWO = 2* ONE;
    parameter	FOUR = 2* TWO;
    parameter
        sound = 50000000/459,
        SP  =   1;  
    
    always @ (number)
    begin
        case(number)
            0:      begin note <= sound;    duration <= QUARTER; done <= 0; end
            1:      begin note <= SP;       duration <= QUARTER; done <= 0; end
            2:      begin note <= sound;    duration <= QUARTER; done <= 0; end
            3: done <= 1;
        endcase
    end
endmodule
