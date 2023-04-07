The email node
=====================

Send an email to one or more recipients

> Note: This node is a sink node and does not output any flow-data, therefore any node connected to this node will not get any data.

Example
-------

{% raw %}
```dfs  
|email()
.to('name@email.com')
.subject('Alert #ex3 EnergyData {{"building"}}')
.body('
    No data since {{"datetime"}} on topic ''home/garage/energy'', 
    last value was {{"val"}}. 
    ')
```

{% endraw %}

Sends an email with the subject 'Alert #ex3 EnergyData'.

The body will be rendered into an html template (see parameters).
Body is a `text_template` parameter with two template-values: `datetime` and `val`, these two fields must be present
in the data_point last received in the email node.
If a field used in a text_template is not found in the current data_point, the string 'undefined' will be used.

{% raw %}
```dfs  

|eval(lambda: str_concat('Module', "mod_number"))
.as('email_subject')
|email()
.to('name@email.com','another@email.com')
.subject_field('email_subject')
.body('
    No data since {{"datetime"}} on topic ''home/garage/energy'', 
    last value was {{"val"}}. 
    ')
```

{% endraw %}

Sends an email with the subject build with a lambda expression to 2 recipients.




Parameters
----------

| Parameter            | Description                               | Default          |
|----------------------|-------------------------------------------|------------------|
| to(`string_list`)    | the recipient email addresses             |                  |
| subject(`text_template`) |                                           |                  |
| body(`text_template`) |                                           |                  |
| body_field(`string`) | field_path used to get the body string    |                  |
| subject_field(`string`)     | field_path used to get the subject string |                  |
| template (`string`)  | html email template to use                | from config file |
| from_address (`string`) |                                           | from config file |
| smtp_relay(`string`) |                                           | from config file |
| smtp_user (`string`) |                                           | from config file |
| smtp_pass (`string`) |                                           | from config file |

`body` or `body_field` must be provided.
`subject` or `subject_field` must be provided.