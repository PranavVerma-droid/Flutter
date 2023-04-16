import sys
from textblob import TextBlob

def main():
    text = sys.argv[1]
    blob = TextBlob(text)

    polarity = blob.sentiment.polarity
    subjectivity = blob.sentiment.subjectivity

    if polarity > 0:
        print('Positive')
    elif polarity < 0:
        print('Negative')
    else:
        print('Neutral')

    print('Subjectivity:', subjectivity)

if __name__ == '__main__':
    main()
