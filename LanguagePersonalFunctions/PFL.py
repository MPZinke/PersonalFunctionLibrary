# Python Personal Functin Libraray


def split_camel_case_and_ignore_consecutive_upper_case_chars(word):
	words = list()
	while word:
		end = 1
		# while the index is in bounds and either the current index is a continuing uppercase or current index is lower
		while end+1 < len(word) 
		and ((word[1].isupper() and word[end+1].isupper()) or word[end].islower()) 
		or end+1 == len(word):
			end += 1

		words.append(word[:end])
		word = word[end:]

	return words


def main():
	pass