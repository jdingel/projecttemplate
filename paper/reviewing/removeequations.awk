#code from https://stackoverflow.com/a/44811404
BEGIN { RS="[\\\\]equation"; ORS=""; FS="" }
NR>1 {
    braceCnt=0
    for (charPos=1; charPos<=NF; charPos++) {
        if ($charPos == "{") { ++braceCnt }
        if ($charPos == "}") { --braceCnt }
        if (braceCnt == 0)   { break }
    }
    $0 = substr($0,charPos+1)
}
# { print }

BEGIN { RS="[\\\\]equation*"; ORS=""; FS="" }
NR>1 {
    braceCnt=0
    for (charPos=1; charPos<=NF; charPos++) {
        if ($charPos == "{") { ++braceCnt }
        if ($charPos == "}") { --braceCnt }
        if (braceCnt == 0)   { break }
    }
    $0 = substr($0,charPos+1)
}
# { print }

BEGIN { RS="[\\\\]align"; ORS=""; FS="" }
NR>1 {
    braceCnt=0
    for (charPos=1; charPos<=NF; charPos++) {
        if ($charPos == "{") { ++braceCnt }
        if ($charPos == "}") { --braceCnt }
        if (braceCnt == 0)   { break }
    }
    $0 = substr($0,charPos+1)
}
# { print }

BEGIN { RS="[\\\\]align*"; ORS=""; FS="" }
NR>1 {
    braceCnt=0
    for (charPos=1; charPos<=NF; charPos++) {
        if ($charPos == "{") { ++braceCnt }
        if ($charPos == "}") { --braceCnt }
        if (braceCnt == 0)   { break }
    }
    $0 = substr($0,charPos+1)
}
{ print }