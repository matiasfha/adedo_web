import java.io.*;
class test{
	public static void main(String[] args) throws IOException{
		Writer w=new BufferedWriter(new FileWriter("bb.txt"));
		w.write(1);
		w.close();
	}
}
