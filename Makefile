#This makefile will only recompile if something has changed, however the.h files do not count so you should use make re if you have changed your header files

NAME = Game

INCLUDES = -I includes/ -I /usr/local/include/SDL2

STATIC_LIB = -l SDL2 -L /usr/local/lib

SRCS_DIR = srcs/
BIN_DIR = bin/

# Name of your source files, if you add , remove or modify the name of a file you should update it here
SRCS_NAMES =	\
	main		\
	render_window \


# This line means to add $(SRC_DIR) (which I have set to srcs/) in front of every word in SRCS_NAMES, and add ".c" at the end of the word
# The synatx is $(addprefix [what you want to add in front], [what you want to add it to])
SRCS = $(addprefix $(SRCS_DIR), $(addsuffix .cpp, $(SRCS_NAMES)))
# Here $(SRCS:.c=.o) means to convert every ".c" into a ".o"
OBJS = $(addprefix $(BIN_DIR), $(SRCS:.cpp=.o))


# This means to execute the command $(NAME) as prerequisite
all: $(NAME)

# This is the command $NAME, it has preqrequisite to exevute $BIN_DIR and $OBJS
$(NAME): $(BIN_DIR) $(OBJS)
	g++ $(FLAGS) $(INCLUDES) -o $(NAME) $(OBJS)  $(STATIC_LIB)
#This is just compiling

#This command makes the /bin directory if it doesn;t exist
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Here we will compile our c files into .o files and put then im the /bin directory so it is more clean
# This runs for every word in $BIN_DIR that ends with .o, which is $OBJS. $(BIN_DIR)%.o expands to /bin/filename.o  and is the target
# $< expans to filename.c
# $< means first argument (file ending with .o) $@ is the target
$(BIN_DIR)%.o: %.cpp
	mkdir -p $(BIN_DIR)$(dir $<)
	g++ $(FLAGS) $(INCLUDES) -c $< -o $@

# recompile everything and run the executable
run: re clean
	./$(NAME)

# deletes object files
clean:
	rm -rf $(BIN_DIR)

# deletes the executable and object files
fclean: clean
	rm -f $(NAME)

# This will recompile everything, including headers.
re: fclean all
	
