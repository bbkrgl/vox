for i in $(seq 1 5); do
	echo "Testing ${i}"
	diff answ/my_lex_tests/test${i}.txt.toks my_lex_tests/test${i}.txt.toks
	diff answ/my_parser_tests/test${i}.vox.ast my_parser_tests/test${i}.vox.ast
done
