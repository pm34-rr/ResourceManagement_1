function printCatalogsAndFiles
{
	# Если количество параметров < 1
	if (( $# < 1 )); then
		#inputDir - это текущая папка
 		inputDir='./'
 	else
 		#inputDir - это первый параметр скрипта
 		inputDir=$1
	fi

	# Вывод имени каталога
	echo $(basename $inputDir)
	# Список файлов в каталоге, отсортированный по длине файлов,
	# по одному имени файла в строке, с выводов длины файла
	# и удалением строки "Итого" с суммарной длиной.
	# awk '{ print $2, $1 }' 	- порядок вывода изменен так, чтобы сначала выводилось имя файла, затем его длина.
	# sed 's/^/\t/' 			- отступ для имени файла.
	ls --sort size -1 -s $inputDir | sed 1d  | awk '{ print $2, $1 }' | sed 's/^/\t/'

	# для каждой поддиректории данной директории выполнить эту же функцию рекурсивно
	for aDir in $(find "$inputDir" -maxdepth 1 -mindepth 1 -type d)
	do
		printCatalogsAndFiles $aDir $2
	done
}

printCatalogsAndFiles $1