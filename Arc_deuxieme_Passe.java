

import java.io.IOException;
import java.util.Scanner;
import java.util.StringTokenizer;
import java.util.*;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

public class Arc_deuxieme_Passe {

  public static class ArcMapper 
       extends Mapper<Object, Text, Text, Text>{
    
    
      
    public void map(Object key, Text value, Context context
            ) throws IOException, InterruptedException {
    
      Scanner letterScanner = new Scanner(value.toString()).useDelimiter("\t");
      Text myKey = new Text(letterScanner.next());
      Text myValue = new Text (letterScanner.next());
      context.write(myKey,myValue);
    }
  }
 
  //Second pass
  public static class DegresReducer 
       extends Reducer<Text,Text,Text,Text> {
    private Text result = new Text();

    public void reduce(Text key, Iterable<Text> values, 
                       Context context
                       ) throws IOException, InterruptedException {
        String line="";
        for (Text val : values) {
    	    line += val + " ";
        }
        
        context.write(key, new Text(line));
    }
  }

  public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
    if (otherArgs.length != 2) {
      System.err.println("Usage: Arc_deuxieme_Passe <in> <out>");
      System.exit(2);
    }
    Job job = new Job(conf, "Arc_deuxieme_Passe");
    job.setJarByClass(Arc_deuxieme_Passe.class);
    job.setMapperClass(ArcMapper.class);
    job.setReducerClass(DegresReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(Text.class);
    FileInputFormat.addInputPath(job, new Path(otherArgs[0]));
    FileOutputFormat.setOutputPath(job, new Path(otherArgs[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}
