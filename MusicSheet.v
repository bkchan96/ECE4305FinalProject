module MusicSheet
(
    input [1:0] number,
    input [1:0] sound,
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
        move = 50000000/459,
        switch = 50000000/980,
        enter = 50000000/700,
        SP  =   1;  
    
    always @ (number, sound)
    begin
        if (sound == 2'b00)
            case(number)
                0:      begin note <= move;     duration <= QUARTER;    done <= 0; end
                1:  done <= 1;
            endcase
        else if (sound == 2'b01)
            case(number)
                0:      begin note <= switch;   duration <= ONE;        done <= 0; end
                1:  done <= 1;
            endcase
        else if (sound == 2'b10)
            case(number)
                0:      begin note <= enter;    duration <= TWO;        done <= 0; end
                1:  done <= 1;
            endcase
        else if (sound == 2'b11) // no sound
            case(number)
                0:      begin note <= SP;        duration <= QUARTER; done <= 0; end
                1:  done <= 1;
            endcase
    end
endmodule
