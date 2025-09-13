(defun read-file (filename)
  "Return the contents of FILENAME"
  (with-temp-buffer
    (insert-file-contents filename)
    (buffer-string))
  )

(defun write-to-file (filename content)
  "Write CONTENT to FILENAME"
  (with-temp-buffer
    (insert content)
    (write-region (point-min) (point-max) filename t))
  )

(defun write-to-file-tool-fn (path content)
  (let* ((full-path (concat (rachytski-current-project-root) path)))
    (progn
      (message (format "tool:write_to_file: path=%S content=%S" full-path content))
      (write-to-file full-path content)
      )))

(defun get-diffs (diff &optional debug)
  (if debug (message format( "DIFF: %S, len=%d" diff (length diff))))  
  (with-temp-buffer
    (insert diff)
    (goto-char (point-min))    
    (let* ((max-pos (+ (buffer-size) 1))
	   (search-tag "------- SEARCH")
	   (separator-tag "=======")
	   (replace-tag "+++++++ REPLACE")
	   (result (list)))
      (while (progn
	       (let* ((search-pos (or (search-forward search-tag nil "smth") max-pos))
		      (separator-pos (or (search-forward separator-tag nil "smth") (+ max-pos 1 (length separator-tag))))
		      (replace-pos (or (search-forward replace-tag nil "smth") (+ max-pos 1 (length replace-tag))))
		      (search-str (buffer-substring (+ search-pos 1) (- separator-pos (+ (length separator-tag) 1))))
		      (replace-str (buffer-substring (+ separator-pos 1) (- replace-pos (+ (length replace-tag) 1))))
		      (has-match (not (eq search-pos max-pos)))
		      (finished (eq replace-pos max-pos)))
		 (if has-match
		     (progn
		       (if debug (message (format "has-match=%s finished=%s max-pos=%d search-pos=%d, separator-pos=%d, replace-pos=%d, search-str=%s, replace-str=%s" has-match finished max-pos search-pos separator-pos replace-pos search-str replace-str)))
		       (setq result (append result (list (list search-str replace-str))))))
		 (not finished)
	       )
	))
        result
      )))

(defun replace-in-file-tool-fn (path diff)
  (let* ((full-path (concat rachytski-current-project-root path)))
    (progn
      (replace-in-file full-path diff)
      )))

(defun replace-in-file (filename diff &optional debug)
  "Replace DIFF in FILENAME"
  (let* ((diffs (get-diffs diff)))
    (with-temp-buffer
      (insert-file-contents filename)
      (goto-char (point-min))      
      (dolist (cur-diff diffs)
	(let* ((search-str (car cur-diff))
	       (replace-str (car (cdr cur-diff))))
	  (if debug (message (format "search=%S, replace=%S" search-str replace-str)))
	  (search-forward search-str nil "smth")
	  (replace-match replace-str)
	  )
	)
      (write-region (point-min) (point-max) filename nil))
    ))

(defun execute-command (command &optional debug)
  (progn
    (with-temp-buffer
      (let ((default-directory (rachytski-current-project-root))
	    (exit-code (call-process-shell-command command nil (current-buffer) nil)))
;;;     (format "EXITCODE: %d, OUTPUT=%S" exit-code (buffer-string))))))
	(buffer-string)
;;;	(if (eq exit-code 0)
;;;	    (buffer-string)
;;;	  (format "error executing %S, output=%S" command (buffer-string))
	  ))))

(defun execute-command-if-approved (command requires_approval &optional debug)
  "Execute command"
  (if debug (message "execute_command command=%S requires_approval=%S" command requires_approval))
  (if (eq requires_approval :json-false)
      (execute-command command)
    (if (eq (yes-or-no-p (format "Execute %S?" command)) t)
	(execute-command command)
      (format "execution of command %S not approved" command))))

(defun read-file-tool-fn (path &optional debug)
  (let* ((full-path (concat (rachytski-current-project-root) path)))  
    (progn
    (if debug (message (format "tool:read_file path=%S" full-path)))
    (read-file full-path)
    )))

(defun execute-command-tool-fn (command requires_approval &optional debug)
  (progn
    (if debug (message (format "tool:execute_command: command=%S requires_approval=%s" command requires_approval)))
    (execute-command-if-approved command requires_approval debug)
    )
  )

(defun select-from-json-array (question json-string)
  "Parse a JSON string containing an array and use it for completion.

The JSON-STRING is parsed, and if it's an array of strings,
`completing-read` is used to prompt the user to select one."
  (let* (;; 1. Parse the JSON string. `json-read-from-string` converts a JSON
         ;;    array into a Lisp vector.
         (completion-candidates json-string))
    
    ;; 2. Check that we got a vector, which is what json-read-from-string
    ;;    produces for a JSON array.
    (if (not (vectorp completion-candidates))
        (error "The provided JSON string is not an array")
      ;; 3. Convert the vector to a list. While completing-read often accepts
      ;;    vectors, using a list is more robust across different Emacs
      ;;    versions and configurations, avoiding potential errors.
      (let ((completion-list (append completion-candidates 'list)))
        (completing-read (format "%S" question) completion-list nil t)))))

(defun attempt-completion-tool-fn (result command &optional debug)
  (progn
    (if debug (message (format "tool:attempt_completion result=%S, command=%S" result command)))
    (if command (execute-command-if-approved command :json-false))
    (if (eq (yes-or-no-p "Complete the task?") t)
	nil ;;"Thank you, the task is completed now. Stop our interaction."
        "Task is incomplete, please try again.")    
    ))

(defun new-task-tool-fn (context &optional debug)
  (if debug (message (format "tool:not_implemented:new_task context=%S" context)))
  nil)

(defun plan-mode-respond-tool-fn (response &optional debug)
  (if debug (message (format "tool:not_implemented:plan_mode_respond response=%S" response)))
  nil)

(defun load-mcp-documentation-tool-fn (&optional debug) 
  (if debug (message (format "tool:not_implemented:load_mcp_documentation")))
  nil)

(defun rachytski-current-project-root ()
  (rachytski-find-project-root (persp-current-name)))

(defun default-system-directive-fn ()
  "Default System Directive Generator"
  (let* ((cpn (persp-current-name))
	 (cpr (rachytski-find-project-root cpn)))
    (format-spec (read-file (expand-file-name "cline-prompt.json" user-init-dir))
		 `((?r . ,cpr)
		   (?o . user-os-name)
		   (?s . user-shell)
		   (?h . user-home-dir))))
  )

(defun search-files-tool-fn (path regex file_pattern &optional debug)
  (let* ((full-path (concat (rachytski-current-project-root) path)))
    (progn
      (if debug (message (format "tool:not_implemented:search_files: path=%S regex=%S file_pattern=%S" full-path regex file_pattern)))
      nil
      )))

(defun list-files-tool-fn (path recursive &optional debug)
  (let* ((full-path (concat (rachytski-current-project-root) path)))
    (progn
      (if debug (message (format "tool:list_files path=%S, recursive=%s" full-path recursive)))
      (if (eq recursive :json-false)
	  (mapconcat #'identity (directory-files-recursively full-path ".*" t '(lambda (dirname) nil)) "\n")
	(mapconcat #'identity (directory-files-recursively full-path ".*" t) "\n")
	))))

(defun list-code-definition-names-tool-fn (path &optional debug)
  (let* ((full-path (concat (rachytski-current-project-root) path)))
    (progn
      (if debug (message (format "tool:not_implemented:list_code_definition_names: path=%S" full-path)))
      nil
      )))

(defun browser-action-tool-fn (action url coordinate text &optional debug)
  (progn
    (if debug (message (format "tool:not_implemented:browser_action: action=%s url=%S coordinate=%S text=%S" action url coordinate text)))
    nil
    ))

(defun use-mcp-tool-tool-fn (server_name tool_name arguments &optional debug)
  (progn
    (if debug (message (format "tool:not_implemented:use_mcp_tool: server_name=%S, tool_name=%S, arguments=%S" server_name tool_name arguments)))
    nil
    ))

(defun access-mcp-resource-tool-fn (server_name url &optional debug)
  (progn
    (if debug (message (format "tool:not_implemented:access_mcp_resource: server_name=%S, uri=%S" server_name uri)))
    nil
    ))

(defun ask-followup-question-tool-fn (question options &optional debug)
  (progn
    (if debug (message (format "tool:ask_followup_question: question=%S options=%S" question options)))
    (if (eq options nil)
	(read-from-minibuffer (concat question "\n"))
      (select-from-json-array question options)
      )
    ))
  
;;; Implement tools, which see. (alaverdy gptel, yo!)
(defun cline-setup-tools ()
  "Setting up tools to use"
  (setq execute-command-tool
	(gptel-make-tool
	 :name "execute_command"		
	 :function (lambda (command requires_approval) (execute-command-tool-fn command requires_approval))
	 :description "Request to execute a CLI command on the system. Use this when you need to perform system operations or run specific commands to accomplish any step in the user's task. You must tailor your command to the user's system and provide a clear explanation of what the command does. For command chaining, use the appropriate chaining syntax for the user's shell. Prefer to execute complex CLI commands over creating executable scripts, as they are more flexible and easier to run. Commands will be executed in the current working directory"
	 :args (list
		'(:name "command" :type string :description "(required) The CLI command to execute. This should be valid for the current operating system. Ensure the command is properly formatted and does not contain any harmful instructions.")
		'(:name "requires_approval" :type boolean :description "(required) A boolean indicating whether this command requires explicit user approval before execution in case the user has auto-approve mode enabled. Set to 'true' for potentially impactful operations like installing/uninstalling packages, deleting/overwriting files, system configuration changes, network operations, or any commands that could have unintended side effects. Set to 'false' for safe operations like reading files/directories, running development servers, building projects, and other non-destructive operations.")
		)
	 :category "filesystem"))
  
  (setq read-file-tool
	(gptel-make-tool
	 :name "read_file"		
	 :function (lambda (path) (read-file-tool-fn path))
	 :description "Request to read the contents of a file at the specified path. Use this when you need to examine the contents of an existing file you do not know the contents of, for example to analyze code, review text files, or extract information from configuration files. Automatically extracts raw text from PDF and DOCX files. May not be suitable for other types of binary files, as it returns the raw content as a string."
	 :args (list
		      '(:name "path" :type string :description "(required) The path of the file to read (relative to the current working directory"))
	 :category "filesystem"))
  (setq write-to-file-tool
	(gptel-make-tool
	 :name "write_to_file"		
	 :function (lambda (path content) (write-to-file-tool-fn path content))
	 :description "Description: Request to write content to a file at the specified path. If the file exists, it will be overwritten with the provided content. If the file doesn't exist, it will be created. This tool will automatically create any directories needed to write the file"
	 :args (list
 		'(:name "path" :type string :description "(required) The path of the file to write to (relative to the current working directory)")
		'(:name "content" :type string :description "(required) The content to write to the file. ALWAYS provide the COMPLETE intended content of the file, without any truncation or omissions. You MUST include ALL parts of the file, even if they haven't been modified.")
		)
	 :category "filesystem"))
  (setq replace-in-file-tool
	(gptel-make-tool
	 :name "replace_in_file"		
	 :function (lambda (path diff) (replace-in-file-tool-fn path diff))
	 :description "Request to replace sections of content in an existing file using SEARCH/REPLACE blocks that define exact changes to specific parts of the file. This tool should be used when you need to make targeted changes to specific parts of a file"
	 :args (list
		'(:name "path" :type string :description "(required) The path of the file to modify (relative to the current working directory)")
		'(:name "diff" :type string :description "(required) One or more SEARCH/REPLACE blocks following this exact format:
  \`\`\`
  ------- SEARCH
  [exact content to find]
  =======
  [new content to replace with]
  +++++++ REPLACE
  \`\`\`
  Critical rules:
  1. SEARCH content must match the associated file section to find EXACTLY:
     * Match character-for-character including whitespace, indentation, line endings
     * Include all comments, docstrings, etc.
  2. SEARCH/REPLACE blocks will ONLY replace the first match occurrence.
     * Including multiple unique SEARCH/REPLACE blocks if you need to make multiple changes.
     * Include *just* enough lines in each SEARCH section to uniquely match each set of lines that need to change.
     * When using multiple SEARCH/REPLACE blocks, list them in the order they appear in the file.
  3. Keep SEARCH/REPLACE blocks concise:
     * Break large SEARCH/REPLACE blocks into a series of smaller blocks that each change a small portion of the file.
     * Include just the changing lines, and a few surrounding lines if needed for uniqueness.
     * Do not include long runs of unchanging lines in SEARCH/REPLACE blocks.
     * Each line must be complete. Never truncate lines mid-way through as this can cause matching failures.
  4. Special operations:
     * To move code: Use two SEARCH/REPLACE blocks (one to delete from original + one to insert at new location)
     * To delete code: Use empty REPLACE section
"))
	 :category "filesystem"))
  (setq search-files-tool
	(gptel-make-tool
	 :name "search_files"
	 :function (lambda (path regex file_pattern) (search-files-tool-fn path regex file_pattern))
	 :description "Request to perform a regex search across files in a specified directory, providing context-rich results. This tool searches for patterns or specific content across multiple files, displaying each match with encapsulating context."
	 :args (list
 		'(:name "path" :type string :description "(required) The path of the directory to search in (relative to the current working directory). This directory will be recursively searched.")
		'(:name "regex" :type string :description "(required) The regular expression pattern to search for. Uses Rust regex syntax.")
		'(:name "file_pattern" :type string :description "(optional) Glob pattern to filter files (e.g., '*.ts' for TypeScript files). If not provided, it will search all files (*).")		       
		)
	 :category "filesystem"))
  (setq list-files-tool 
	(gptel-make-tool
	 :name "list_files"		
	 :function (lambda (path recursive) (list-files-tool-fn path recursive))
	 :description "Request to list files and directories within the specified directory. If recursive is true, it will list all files and directories recursively. If recursive is false or not provided, it will only list the top-level contents. Do not use this tool to confirm the existence of files you may have created, as the user will let you know if the files were created successfully or not."
	 :args (list
		'(:name "path" :type string :description "(required) The path of the directory to list contents for (relative to the current working directory)")
		'(:name "recursive" :type boolean :description "(optional) Whether to list files recursively. Use true for recursive listing, false or omit for top-level only."))
	 :category "filesystem"))
  (setq list-code-definition-names-tool
	(gptel-make-tool
	 :name "list_code_definition_names"		
	 :function (lambda (path) (list-code-definition-names-tool-fn path))
	 :description "Request to list definition names (classes, functions, methods, etc.) used in source code files at the top level of the specified directory. This tool provides insights into the codebase structure and important constructs, encapsulating high-level concepts and relationships that are crucial for understanding the overall architecture."
	 :args (list
 		'(:name "path" :type string :description "(required) The path of the directory (relative to the current working directory) to list top level source code definitions for.")
		)
	 :category "filesystem"))
  (setq browser-action-tool
	(gptel-make-tool
	 :name "browser_action"		
	 :function (lambda (action url coordinate text) (browser-action-tool-fn action url coordinate text))
	 :description "Request to interact with a Puppeteer-controlled browser. Every action, except \`close\`, will be responded to with a screenshot of the browser's current state, along with any new console logs. You may only perform one browser action per message, and wait for the user's response including a screenshot and logs to determine the next action.
- The sequence of actions **must always start with** launching the browser at a URL, and **must always end with** closing the browser. If you need to visit a new URL that is not possible to navigate to from the current webpage, you must first close the browser, then launch again at the new URL.
- While the browser is active, only the \`browser_action\` tool can be used. No other tools should be called during this time. You may proceed to use other tools only after closing the browser. For example if you run into an error and need to fix a file, you must close the browser, then use other tools to make the necessary changes, then re-launch the browser to verify the result.
- The browser window has a resolution of **3440x1440** pixels. When performing any click actions, ensure the coordinates are within this resolution range.
- Before clicking on any elements such as icons, links, or buttons, you must consult the provided screenshot of the page to determine the coordinates of the element. The click should be targeted at the **center of the element**, not on its edges.
Parameters:
- action: (required) The action to perform. The available actions are:
    * launch: Launch a new Puppeteer-controlled browser instance at the specified URL. This **must always be the first action**.
        - Use with the \`url\` parameter to provide the URL.
        - Ensure the URL is valid and includes the appropriate protocol (e.g. http://localhost:3000/page, file:///path/to/file.html, etc.)
    * click: Click at a specific x,y coordinate.
        - Use with the \`coordinate\` parameter to specify the location.
        - Always click in the center of an element (icon, button, link, etc.) based on coordinates derived from a screenshot.
    * type: Type a string of text on the keyboard. You might use this after clicking on a text field to input text.
        - Use with the \`text\` parameter to provide the string to type.
    * scroll_down: Scroll down the page by one page height.
    * scroll_up: Scroll up the page by one page height.
    * close: Close the Puppeteer-controlled browser instance. This **must always be the final browser action**.
        - Example: \`<action>close</action>\`
- url: (optional) Use this for providing the URL for the \`launch\` action.
    * Example: <url>https://example.com</url>
- coordinate: (optional) The X and Y coordinates for the \`click\` action. Coordinates should be within the **3440x1440** resolution.
    * Example: <coordinate>450,300</coordinate>
- text: (optional) Use this for providing the text for the \`type\` action.
    * Example: <text>Hello, world!</text>"
	 :args (list
		'(:name "action" :type string :description "(required) The action to perform. The available actions are:
    * launch: Launch a new Puppeteer-controlled browser instance at the specified URL. This **must always be the first action**.
        - Use with the \`url\` parameter to provide the URL.
        - Ensure the URL is valid and includes the appropriate protocol (e.g. http://localhost:3000/page, file:///path/to/file.html, etc.)
    * click: Click at a specific x,y coordinate.
        - Use with the \`coordinate\` parameter to specify the location.
        - Always click in the center of an element (icon, button, link, etc.) based on coordinates derived from a screenshot.
    * type: Type a string of text on the keyboard. You might use this after clicking on a text field to input text.
        - Use with the \`text\` parameter to provide the string to type.
    * scroll_down: Scroll down the page by one page height.
    * scroll_up: Scroll up the page by one page height.
    * close: Close the Puppeteer-controlled browser instance. This **must always be the final browser action**.
        - Example: \`<action>close</action>\`")
		'(:name "url" :type string :description "(optional) Use this for providing the URL for the \`launch\` action.
    * Example: <url>https://example.com</url>")
		'(:name "coordinate" :type string :description "(optional) The X and Y coordinates for the \`click\` action. Coordinates should be within the **3440x1440** resolution.
    * Example: <coordinate>450,300</coordinate>")
		'(:name "text" :type string :description "(optional) Use this for providing the text for the \`type\` action.
    * Example: <text>Hello, world!</text>")
		)
	 :category "filesystem"))
  (setq use-mcp-tool-tool
	(gptel-make-tool
	 :name "use_mcp_tool"
	 :function (lambda (server_name tool_name arguments) (use-mcp-tool-tool-fn server_name tool_name arguments))
	 :description "Request to use a tool provided by a connected MCP server. Each MCP server can provide multiple tools with different capabilities. Tools have defined input schemas that specify required and optional parameters."
	 :args (list
 		'(:name "server_name" :type string :description "(required) The name of the MCP server providing the tool")
		'(:name "tool_name" :type string :description "(required) The name of the tool to execute")
		'(:name "arguments" :type string :description "(required) A JSON object containing the tool's input parameters, following the tool's input schema")
		)
	 :category "filesystem"))
  (setq access-mcp-resource-tool
	(gptel-make-tool
	 :name "access_mcp_resource"
	 :function (lambda (server_name uri) (access-mcp-resource-tool-fn server_name uri))
	 :description "Request to access a resource provided by a connected MCP server. Resources represent data sources that can be used as context, such as files, API responses, or system information."
	 :args (list
 		'(:name "server_name" :type string :description "(required) The name of the MCP server providing the resource")
		'(:name "uri" :type string :description "(required) The URI identifying the specific resource to access")
		)
	 :category "filesystem"))
  (setq ask-followup-question-tool
	(gptel-make-tool
	 :name "ask_followup_question"		
	 :function (lambda (question options) (ask-followup-question-tool-fn question options))
	 :description "Ask the user a question to gather additional information needed to complete the task. This tool should be used when you encounter ambiguities, need clarification, or require more details to proceed effectively. It allows for interactive problem-solving by enabling direct communication with the user. Use this tool judiciously to maintain a balance between gathering necessary information and avoiding excessive back-and-forth."
	 :args (list
		'(:name "question" :type string :description "The question to ask the user. This should be a clear, specific question that addresses the information you need.")
		'(:name "options" :type array :items (:type string) :description "An array of 2-5 options for the user to choose from. Each option should be a string describing a possible answer. You may not always need to provide options, but it may be helpful in many cases where it can save the user from having to type out a response manually. IMPORTANT: NEVER include an option to toggle to Act mode, as this would be something you need to direct the user to do manually themselves if needed.")
		)
	 :category "filesystem"))
  (setq attempt-completion-tool
	(gptel-make-tool
	 :name "attempt_completion"
	 :function (lambda (result command) (attempt-completion-tool-fn result command))
	 :description "After each tool use, the user will respond with the result of that tool use, i.e. if it succeeded or failed, along with any reasons for failure. Once you've received the results of tool uses and can confirm that the task is complete, use this tool to present the result of your work to the user. Optionally you may provide a CLI command to showcase the result of your work. The user may respond with feedback if they are not satisfied with the result, which you can use to make improvements and try again."
	 :args (list
		'(:name "result" :type string :description "(required) The result of the task. Formulate this result in a way that is final and does not require further input from the user. Don't end your result with questions or offers for further assistance.")
		'(:name "command" :type string :description "(optional) A CLI command to execute to show a live demo of the result to the user. For example, use \`open index.html\` to display a created html website, or \`open localhost:3000\` to display a locally running development server. But DO NOT use commands like \`echo\` or \`cat\` that merely print text. This command should be valid for the current operating system. Ensure the command is properly formatted and does not contain any harmful instructions.")
		)
	 :category "filesystem"))
  (setq new-task-tool
	(gptel-make-tool
	 :name "new_task"
	 :function (lambda (context) (new-task-tool-fn context))
	 :description "Request to create a new task with preloaded context covering the conversation with the user up to this point and key information for continuing with the new task. With this tool, you will create a detailed summary of the conversation so far, paying close attention to the user's explicit requests and your previous actions, with a focus on the most relevant information required for the new task.\nAmong other important areas of focus, this summary should be thorough in capturing technical details, code patterns, and architectural decisions that would be essential for continuing with the new task. The user will be presented with a preview of your generated context and can choose to create a new task or keep chatting in the current conversation. The user may choose to start a new task at any point.
"
	 :args (list
		'(:name "context" :type string :description "(required) The context to preload the new task with. If applicable based on the current task, this should include:
  1. Current Work: Describe in detail what was being worked on prior to this request to create a new task. Pay special attention to the more recent messages / conversation.
  2. Key Technical Concepts: List all important technical concepts, technologies, coding conventions, and frameworks discussed, which might be relevant for the new task.
  3. Relevant Files and Code: If applicable, enumerate specific files and code sections examined, modified, or created for the task continuation. Pay special attention to the most recent messages and changes.
  4. Problem Solving: Document problems solved thus far and any ongoing troubleshooting efforts.
  5. Pending Tasks and Next Steps: Outline all pending tasks that you have explicitly been asked to work on, as well as list the next steps you will take for all outstanding work, if applicable. Include code snippets where they add clarity. For any next steps, include direct quotes from the most recent conversation showing exactly what task you were working on and where you left off. This should be verbatim to ensure there's no information loss in context between tasks. It's important to be detailed here.
")
		)
	 :category "filesystem"))
  (setq plan-mode-respond-tool
	(gptel-make-tool
	 :name "plan_mode_respond"
	 :function (lambda (response) (plan-mode-respond-tool-fn response))
	 :description "Respond to the user's inquiry in an effort to plan a solution to the user's task. This tool should be used when you need to provide a response to a question or statement from the user about how you plan to accomplish the task. This tool is only available in PLAN MODE. The environment_details will specify the current mode, if it is not PLAN MODE then you should not use this tool. Depending on the user's message, you may ask questions to get clarification about the user's request, architect a solution to the task, and to brainstorm ideas with the user. For example, if the user's task is to create a website, you may start by asking some clarifying questions, then present a detailed plan for how you will accomplish the task given the context, and perhaps engage in a back and forth to finalize the details before the user switches you to ACT MODE to implement the solution."
	 :args (list
		'(:name "response" :type string :description "(required) The response to provide to the user. Do not try to use tools in this parameter, this is simply a chat response. (You MUST use the response parameter, do not simply place the response text directly within <plan_mode_respond> tags.)")
		)
	 :category "filesystem"))
  (setq load-mcp-documentation-tool
	(gptel-make-tool
	 :name "load_mcp_documentation"
	 :function (lambda () (load-mcp-documentation-tool-fn))
	 :description "Load documentation about creating MCP servers. This tool should be used when the user requests to create or install an MCP server (the user may ask you something along the lines of \"add a tool\" that does some function, in other words to create an MCP server that provides tools and resources that may connect to external APIs for example. You have the ability to create an MCP server and add it to a configuration file that will then expose the tools and resources for you to use with \`use_mcp_tool\` and \`access_mcp_resource\`). The documentation provides detailed information about the MCP server creation process, including setup instructions, best practices, and examples."
	 :args (list)
	 :category "filesystem"))
  
  (add-to-list 'gptel-tools execute-command-tool)
  (add-to-list 'gptel-tools read-file-tool)
  (add-to-list 'gptel-tools write-to-file-tool)
  (add-to-list 'gptel-tools replace-in-file-tool)
  (add-to-list 'gptel-tools search-files-tool)
  (add-to-list 'gptel-tools list-files-tool)
  (add-to-list 'gptel-tools list-code-definition-names-tool)
  (add-to-list 'gptel-tools browser-action-tool)
  (add-to-list 'gptel-tools use-mcp-tool-tool)
  (add-to-list 'gptel-tools access-mcp-resource-tool)
  (add-to-list 'gptel-tools ask-followup-question-tool)
  (add-to-list 'gptel-tools attempt-completion-tool)
  (add-to-list 'gptel-tools new-task-tool)
  (add-to-list 'gptel-tools plan-mode-respond-tool)
  (add-to-list 'gptel-tools load-mcp-documentation-tool)
  )

