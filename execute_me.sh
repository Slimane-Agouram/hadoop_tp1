echo "***********************************************HADOOP GRAPH DEGREE EXTRACTOR*********************************"
echo "***************************************************Par Slimane AGOURAM***************************************" 

PS3='Please enter your choice: '
options=("Clean directory" "Compile and run" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Clean directory")
            echo "you chose was to clean this directory:"
            rm -rf Arc_premiere_Passe
            rm -rf Arc_deuxieme_Passe
            rm -rf Output_Premiere_Passe
            rm -rf Output_Deuxieme_Passe
            rm -f *.jar
            echo "done cleaning directory from useless jars and sub-directories..."

            ;;
        "Compile and run")
            echo "you chose to compile and run the hadoop example"
            printf '%s \n' "/////creating directory for our java classes"
mkdir -p Arc_premiere_Passe
mkdir -p Arc_deuxieme_Passe

printf '%s \n' "/////compiling our first hadoop pass class"
javac -classpath ${HADOOP_HOME}/hadoop-core-${HADOOP_VERSION}.jar:$HADOOP_HOME/lib/commons-cli-1.2.jar -d Arc_premiere_Passe/ Arc_premiere_Passe.java
printf '%s \n' "////done compiling first pass"
printf '%s \n' "////creating the jar for our first pass"
jar -cvf arc_premiere_passe.jar -C Arc_premiere_Passe/ .
printf '%s \n' "////done creating the first jar"


printf '%s \n' "////deleting first output directory if it exists"
rm -rf Output_Premiere_Passe
printf '%s \n' "////done deleting first exisiting output"


printf '%s \n' "////executing our first pass hadoop pass"
${HADOOP_HOME}/bin/hadoop jar arc_premiere_passe.jar Arc_premiere_Passe input_Premiere_Passe Output_Premiere_Passe
printf '%s \n' "////end of execution of the first pass, begining the second pass"

printf '%s \n' "////compiling our second hadoop pass class"
javac -classpath ${HADOOP_HOME}/hadoop-core-${HADOOP_VERSION}.jar:$HADOOP_HOME/lib/commons-cli-1.2.jar -d Arc_deuxieme_Passe/ Arc_deuxieme_Passe.java
printf '%s \n' "////done compiling second pass"
printf '%s \n' "////creating the jar for our second pass"
jar -cvf arc_deuxieme_passe.jar -C Arc_deuxieme_Passe/ .
printf '%s \n' "////done creating the second jar"

printf '%s \n' "////deleting second output directory if it exists"
rm -rf Output_Deuxieme_Passe
printf '%s \n' "////done deleting second exisiting output"

printf '%s \n' "////executing our second pass hadoop pass"
${HADOOP_HOME}/bin/hadoop jar arc_deuxieme_passe.jar Arc_deuxieme_Passe Output_Premiere_Passe Output_Deuxieme_Passe
printf '%s \n' "/////end of execution of the second pass."
printf '\n%s \n' "***********************END and SUCCESS***********************"

printf '\n%s \n' "***********************NOW OPENING OUTPUT FILE***********************"
sleep 2
vi Output_Deuxieme_Passe/part-r-00000
            ;;
        
        "Quit")
            break
            ;;
        *)  echo "choice not found, i'm closing..."
			break
            ;;
    esac
done

# printf '%s \n' "/////creating directory for our java classes"
# mkdir -p Arc_premiere_Passe
# mkdir -p Arc_deuxieme_Passe

# printf '%s \n' "/////compiling our first hadoop pass class"
# javac -classpath ${HADOOP_HOME}/hadoop-core-${HADOOP_VERSION}.jar:$HADOOP_HOME/lib/commons-cli-1.2.jar -d Arc_premiere_Passe/ Arc_premiere_Passe.java
# printf '%s \n' "////done compiling first pass"
# printf '%s \n' "////creating the jar for our first pass"
# jar -cvf arc_premiere_passe.jar -C Arc_premiere_Passe/ .
# printf '%s \n' "////done creating the first jar"


# printf '%s \n' "////deleting first output directory if it exists"
# rm -rf Output_Premiere_Passe
# printf '%s \n' "////done deleting first exisiting output"


# printf '%s \n' "////executing our first pass hadoop pass"
# ${HADOOP_HOME}/bin/hadoop jar arc_premiere_passe.jar Arc_premiere_Passe input_Premiere_Passe Output_Premiere_Passe
# printf '%s \n' "////end of execution of the first pass, begining the second pass"

# printf '%s \n' "////compiling our second hadoop pass class"
# javac -classpath ${HADOOP_HOME}/hadoop-core-${HADOOP_VERSION}.jar:$HADOOP_HOME/lib/commons-cli-1.2.jar -d Arc_deuxieme_Passe/ Arc_deuxieme_Passe.java
# printf '%s \n' "////done compiling second pass"
# printf '%s \n' "////creating the jar for our second pass"
# jar -cvf arc_deuxieme_passe.jar -C Arc_deuxieme_Passe/ .
# printf '%s \n' "////done creating the second jar"

# printf '%s \n' "////deleting second output directory if it exists"
# rm -rf Output_Deuxieme_Passe
# printf '%s \n' "////done deleting second exisiting output"

# printf '%s \n' "////executing our second pass hadoop pass"
# ${HADOOP_HOME}/bin/hadoop jar arc_deuxieme_passe.jar Arc_deuxieme_Passe Output_Premiere_Passe Output_Deuxieme_Passe
# printf '%s \n' "/////end of execution of the second pass."
# printf '\n%s \n' "***********************END and SUCCESS***********************"

# printf '\n%s \n' "***********************Now opening final output file***********************"
# vi Output_Deuxieme_Passe/part-r-00000
