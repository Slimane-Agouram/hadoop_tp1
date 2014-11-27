

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

public class Arc_premiere_Passe {

  public static class ArcMapper 
       extends Mapper<Object, Text, Text, Text>{
    
    
      
    public void map(Object key, Text value, Context context
            ) throws IOException, InterruptedException {
    
      Scanner letterScanner = new Scanner(value.toString()).useDelimiter("[^A-Z]+");
      Text leftLetter = new Text(letterScanner.next());
      Text rigthLetter = new Text (letterScanner.next());
      context.write(leftLetter,value);
      context.write(rigthLetter,value);
    }
  }
 
  //first pass
  public static class DegresReducer 
       extends Reducer<Text,Text,Text,Text> {
    private Text result = new Text();

    public void reduce(Text key, Iterable<Text> values, 
                       Context context
                       ) throws IOException, InterruptedException {
        int sum=0;
        String line="";
        List<String> v = new ArrayList<String>();

        for (Text val : values) {
    	    v.add(val+"");
        }
        
        for(int i=0; i<v.size(); i++)
            context.write(new Text(v.get(i)),new Text("d("+key+")="+v.size()));
    }
  }

  public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
    if (otherArgs.length != 2) {
      System.err.println("Usage: Arc_premiere_Passe <in> <out>");
      System.exit(2);
    }
    Job job = new Job(conf, "Arc_premiere_Passe");
    job.setJarByClass(Arc_premiere_Passe.class);
    job.setMapperClass(ArcMapper.class);
    //job.setCombinerClass(DegresCombiner.class);
    job.setReducerClass(DegresReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(Text.class);
    FileInputFormat.addInputPath(job, new Path(otherArgs[0]));
    FileOutputFormat.setOutputPath(job, new Path(otherArgs[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}
