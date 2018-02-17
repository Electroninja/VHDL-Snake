# VHDL-Snake
By Lutulu Mbiye

This Project is the game snake designed for the Basys 2 Spartan 3E FPGA board.

Due to the limited space of the board, the snake tail will ony grow to a lenght of 32 squares. Additionally the tail will reset back to on every 33rd food.

Originally the snake could grow to the size of 64, but the board has trouble outputting properly on some monitors. Colors would be missing, and the screen would keep going black. Most notably when the player gets a game over, the screen should turn white, but on some monitors, it would turn black instead. I added a led indicator for game overs, however it resulted in the design taking up more than the board could handle. So, the easiest fix was to reduce the tail length by a factor of 2.
