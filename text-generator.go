package main

import (
	"bytes"
	"math/rand"
	"strings"
)

func main() {
	text := "Specifies a local “dynamic” application-level port forwarding.  This works by allocating a socket to listen  to  port  on  the  local side,  optionally  bound to the specified bind_address.  Whenever a connection is made to this port, the connection is forwarded over the secure channel, and the application protocol is then used to determine where to connect to from the  remote  machine.   Currently the  SOCKS4 and SOCKS5 protocols are supported, and ssh will act as a SOCKS server.  Only root can forward privileged ports.  Dynamic port forwardings can also be specified in the configuration file. IPv6 addresses can be specified by enclosing the address in square brackets.  Only the superuser can forward  privileged  ports.   By default,  the local port is bound in accordance with the GatewayPorts setting.  However, an explicit bind_address may be used to bind the connection to a specific address.  The bind_address of “localhost” indicates that the listening port be bound for local use only, while an empty address or ‘*’ indicates that the port should be available from all interfaces."
	text = strings.ToLower(text)
	text_words := strings.Split(text, " ")

	shuffleArray(text_words)
	created_text := buildString(text_words, len(text))
	print(created_text)
}

func buildString(text_words []string, text_length int) string {
	raw_buffer := make([]byte, text_length)
	text_buffer := bytes.NewBuffer(raw_buffer)
	is_uppercase_next_word_first_letter := false

	for i, word := range text_words {
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
	if text_end == '?' || text_end == '!' || text_end == '.' {
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
