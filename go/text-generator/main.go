package main

import (
	"bytes"
	"math/rand"
	"os"
	"strings"
)

var manual = `
    Simple utility to quickly generate random sentences for testing purposes.
    Designed to be combined with other helpful utils.
    Returns plain text as output. By default produces text in Engilish language.

    options:
    -h --help             open manual page
    -l -lang --language   choose language of generated text (supported: EN, RU)
    `
var text = "Specifies a local “dynamic” application-level port forwarding. This works by allocating a socket to listen  to  port  on  the  local side,  optionally  bound to the specified bind_address.  Whenever a connection is made to this port, the connection is forwarded over the secure channel, and the application protocol is then used to determine where to connect to from the  remote  machine.   Currently the  SOCKS4 and SOCKS5 protocols are supported, and ssh will act as a SOCKS server.  Only root can forward privileged ports.  Dynamic port forwardings can also be specified in the configuration file. IPv6 addresses can be specified by enclosing the address in square brackets.  Only the superuser can forward  privileged  ports.   By default,  the local port is bound in accordance with the GatewayPorts setting.  However, an explicit bind_address may be used to bind the connection to a specific address.  The bind_address of “localhost” indicates that the listening port be bound for local use only, while an empty address or ‘*’ indicates that the port should be available from all interfaces."

func main() {
	args := os.Args[1:]
	proccessArgs(args)

	text = strings.ToLower(text)
	text_words := strings.Split(text, " ")

	shuffleArray(text_words)
	created_text := buildString(text_words, len(text))
	print(created_text)
}

func proccessArgs(args []string) {
	for i, arg := range args {
		switch arg {
		case "-h", "--help":
			print(manual)
			os.Exit(1)
		case "-l", "--language", "-lang":
			if len(args) < i+1 {
				print("You must specify available language from available: EN, RU")
				os.Exit(1)
			}
			chooseTextLang(args[i+1])
		}
	}
}

func chooseTextLang(next_arg string) {
	switch next_arg {
	case "EN", "ENG":
	case "RU", "RUS":
		text = "Субъектом современного научного познания является именно научный коллектив, состоящий из множества отдельных ученых, которые объединены единым предметом исследования. Более того, в развитии современной науки и научного знания все более проявляются тренды глобализации науки. Дело в том, что в современной мировой науке члены одного и того же дисциплинарного научного сообщества, с одной стороны, существенно распределены в пространстве и часто вообще незнакомы друг с другом. С другой стороны, они являются неким единым целым как представляющим конкретную область исследования. Что же их связывает друг с другом и делает единым коллективным субъектом научного познания? Ответ очевиден: очень густая сеть информационных каналов и когнитивных связей между отдельными учеными и научными организациями, в том числе благодаря современным средствам связи, причем благодаря Интернету часто неформальным и социально анонимным, не регулируемых из какого-то центра. Результатом таких интенсивных коммуникаций внутри коллективного субъекта науки является достижение среди его членов определенного консенсуса в отношении истинности, доказанности, однозначности и эффективности той или иной концепции или гипотезы. В отличие научного консенсуса от научных конвенций как способов достижения согласия в науке? Конвенции являются результатом сознательно-договорного и рационально-контролируемого поведения ученых относительно принятия в качестве истинных определенных высказываний и теорий. В отличие от них научный консенсус является итогом длительных переговоров, дискуссий, включая столкновение различных позиций ученых, во многом этот процесс когнитивных коммуникаций в науке является стихийным, а, следовательно, объективным. Необходимо при этом особо отметить то обстоятельство, что существенную роль в достижении научного консенсуса играет позиция ведущих ученых в соответствующей области научного знания, ее наиболее авторитетных экспертов. Если научная конвенция – дело личной ответственности отдельного ученого, то научный консенсус – коллективное действие дисциплинарного научного сообщества и его коллективная ответственность за признание некоторой теории научной, истинной, или ненаучной и лженаучной. Различие в основаниях и механизме принятия когнитивных решений при конвенционалистской и консенсуалистской познавательной стратегии весьма существенны. При конвенционалистской стратегии механизма принятия и утверждения некоторой единицы знания в качестве истинной при всех оговорках это решение имеет субъективный характер. Тогда как при консенсуалисткой стратегии решения вопроса об истинности научного знания субъективизм такого решения максимально устраняется в силу в силу самой природы консенсуса как коллективного общезначимого решения научного сообщества, пусть и во многом стихийного. Хотя в обоих случаях научная истина признается имеющей условный и относительный характер, но только при консенсуалистском подходе она приобретает еще и такие свойства как объективность, социальность и историчность, что полностью соответствует реальному процессу научного познания. В марксистской философии науки был разработан и предложен в качестве критерия истинности научного знания критерий практики, под которым понималась материальная деятельность людей. В науке материальная деятельность существует в трех формах: физический эксперимент, внедрение результатов научного знания в производственной и технической сфере, использование различного рода научных приборов. Понимание практики в качестве критерия истинности научного знания сталкивается со следующего рода принципиальными трудностям Такими теориями являются все математические теории, начиная с арифметики натуральных и рациональных чисел и эвклидовой геометрии, построенной греческими математиками. Первая физическая трансцендентальная теория была построена только в Новое время. И это была классическая механика Ньютона. Сегодня трансцедентальные научные теории имеются в большинстве естественных и технических наук, а также во многих социально-гуманитарных дисциплинах. Более того, в структуре теоретического знания современной науки имеются трансцендентальные теории разной степени общности: частные теории и более общие фундаментальные теории, а среди них самые общие или парадигмальные теории той или иной области науки или даже науки в целом. Такими теориями в современном естествознании являются, например, частная и общая теория относительности, квантовая механика, квантовая электродинамика, релятивистская космология, теория элементарных частиц, синергетика, генетика и молекулярная биология и др. Критерий истинности трансцендентальных теорий существенно отличается от критериев истинности чувственного и эмпирического знания в науке. Поскольку непосредственный предмет (онтологию) трансцендентальных теорий образует множество идеальных, чисто мысленных (ненаблюдаемых) объектов (материальная точка, инерция, абсолютное пространство, абсолютное время, абсолютно изолированная термодинамическая система, идеальный газ, абсолютно черное тело, пространственно-временной континуум и др.), их свойства и отношения, постольку соответствие опыту не может быть критерием истинности таких теорий, поскольку они ничего не утверждают о нем. Главными требованиями к истинности трансцендентальной теории являются, прежде всего, интуитивная очевидность содержания ее идеальных объектов и аксиом теории. Основными же средствами разворачивания содержания такой теории является постепенное, пошаговое ее построение с помощью логических и внелогических средств, контролируемых интеллектуальной интуицией (Декарт). Необходимо отметить, что любая трансцендентальная теория является самодостаточной по отношению к миру опыта, поскольку имеет свои собственные онтологические основания. Но она не является самодостаточной по отношению к теоретическому знанию науки в целом, будучи одним из его элементов."
	}
}

func buildString(text_words []string, text_length int) string {
	raw_buffer := make([]byte, text_length)
	text_buffer := bytes.NewBuffer(raw_buffer)
	is_uppercase_next_word_first_letter := false

	edge := rand.Intn(len(text_words))

	for i, word := range text_words {
		if i == edge {
			break
		}

		if len(word) == 0 {
			continue
		} else if len(word) == 1 {
			text_buffer.WriteString(string(strings.ToUpper(word)[0]) + " ")
			continue
		}
		word_end := word[len(word)-1]
		if word_end == '?' || word_end == '!' || word_end == '.' {
			is_uppercase_next_word_first_letter = true
			text_buffer.WriteString(word + " ")
		} else if is_uppercase_next_word_first_letter || i == 0 {
			is_uppercase_next_word_first_letter = false
			uppercased_str := strings.ToUpper(string(word[0])) + word[1:]
			text_buffer.WriteString(uppercased_str + " ")
		} else {
			text_buffer.WriteString(word + " ")
		}
	}

	created_text := text_buffer.String()[0 : text_buffer.Len()-1]
	text_end := rune(created_text[len(created_text)-1])
	if text_end == '?' || text_end == '!' || text_end == '.' || text_end == ',' {
		return created_text
	} else {
		return created_text + "."
	}
}

func shuffleArray(text_words []string) {
	for i, word := range text_words {
		some_idx := rand.Intn(len(text_words))
		text_words[i] = text_words[some_idx]
		text_words[some_idx] = word
	}
}
