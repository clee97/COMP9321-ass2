package services;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import unsw.curation.api.domain.abstraction.IKeywordEx;
import unsw.curation.api.tokenization.ExtractionKeywordImpl;

public class ExtractorService {
	
	public static void main(String[] args) {
		try {
			System.out.println(bullyWordsDictionary());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static IKeywordEx keywordExtractor = new ExtractionKeywordImpl();
	
	public static List<String> extractKeywords(String post) throws Exception{
		return new ArrayList<String>(Arrays.asList(keywordExtractor.ExtractSentenceKeyword(post, new File("englishStopwords.txt")).split(","))).stream().map(m->m.toLowerCase()).collect(Collectors.toList());
	}
	
	public static List<String> bullyWordsDictionary() throws IOException{
		FileReader in = new FileReader("bullyWords.txt");
		BufferedReader br = new BufferedReader(in);
		
		String line;
		List<String> list = new ArrayList<String>();
		while ((line = br.readLine()) != null) {
		    list.addAll(new ArrayList<String>(Arrays.asList(line.split(","))).stream().map(m->m.trim()).collect(Collectors.toList()));
		}
		in.close();
		return list.stream().map(w->w.toLowerCase()).collect(Collectors.toList());
	}
}
