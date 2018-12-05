`timescale 1ns / 1ps

module top(clk, reset, dreset, ps2d, ps2c, hsync, vsync, rgb, audioOut, aud_sd);
    input clk, reset, dreset;
    input ps2d, ps2c;
    output hsync, vsync;
    output [11:0] rgb;
    output audioOut, aud_sd;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // Keyboard section
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // declare wires
    wire left, right, up, down, enter, game_reset;
    wire rx_done_tick;
    wire [7:0] scan_code;
    wire key_left, key_right, key_up, key_down, key_game_reset, key_enter;
    
    // instantiate ps2 module
    ps2_rx u_ps2_rx(.clk(clk), .reset(reset), .ps2d(ps2d), .ps2c(ps2c), .rx_en(1'b1), .rx_done_tick(rx_done_tick), .dout(scan_code));
    
    // instantiate 
    kb_controller kb_left(.clk(clk), .reset(reset), .scan_done_tick(rx_done_tick), .scan_code(scan_code),
        .scan_code_read(8'h1C),
        .key(key_left));

    kb_controller kb_right(.clk(clk), .reset(reset), .scan_done_tick(rx_done_tick), .scan_code(scan_code),
        .scan_code_read(8'h23),
        .key(key_right));

    kb_controller kb_up(.clk(clk), .reset(reset), .scan_done_tick(rx_done_tick), .scan_code(scan_code),
        .scan_code_read(8'h1D),
        .key(key_up));

    kb_controller kb_down(.clk(clk), .reset(reset), .scan_done_tick(rx_done_tick), .scan_code(scan_code),
        .scan_code_read(8'h1B),
        .key(key_down));

    kb_controller kb_game_reset(.clk(clk), .reset(reset), .scan_done_tick(rx_done_tick), .scan_code(scan_code),
        .scan_code_read(8'h2D),
        .key(key_game_reset));

    kb_controller kb_enter(.clk(clk), .reset(reset), .scan_done_tick(rx_done_tick), .scan_code(scan_code),
        .scan_code_read(8'h29),
        .key(key_enter));
    
    // keyboard blip modules
    blipgen u_bleft (.in(key_left),  .clk(clk), .reset(reset), .out(left));
    blipgen u_bright(.in(key_right), .clk(clk), .reset(reset), .out(right));
    blipgen u_bup   (.in(key_up),    .clk(clk), .reset(reset), .out(up));
    blipgen u_bdown (.in(key_down),  .clk(clk), .reset(reset), .out(down));
    blipgen u_benter(.in(key_enter), .clk(clk), .reset(reset), .out(enter));
    blipgen u_game_reset(.in(key_game_reset), .clk(clk), .reset(reset), .out(game_reset));
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // Sound Section
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // declare wire
    wire playSound;
    wire [1:0] sound;
    
    SongPlayer u_player(.clock(clk), .reset(reset), .sound(sound), .playSound(playSound), .audioOut(audioOut), .aud_sd(aud_sd));
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // VGA Output/Game Control Section
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // signal declaration
    wire [9:0] pixel_x, pixel_y;
    wire video_on, pixel_tick;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    
    // vga_sync instantiation
    vga_sync u_vga_sync(.clk(clk), .reset(~dreset), .hsync(hsync), .vsync(vsync),
        .video_on(video_on), .p_tick(pixel_tick), .pixel_x(pixel_x), .pixel_y(pixel_y));
    
    // display and game engine instantiation
    display u_display(.video_on(video_on), .pix_x(pixel_x), .pix_y(pixel_y), .graph_rgb(rgb_next), .clk(clk), .reset(reset),
        .left(left), .right(right), .up(up), .down(down), .enter(enter), .game_reset(game_reset), .sound(sound), .playSound(playSound));
    
    // assign output
    assign rgb = rgb_reg;
    
    // rgb buffer
    always @(posedge clk)
        if (pixel_tick)
            rgb_reg <= rgb_next;

endmodule
