{{- define "deploy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "deploy.node.name" -}}
{{- default .Chart.Name .Values.node.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "deploy.node.fullname" -}}
{{- if .Values.node.fullnameOverride -}}
{{- .Values.node.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.node.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "deploy.node.labels" -}}
helm.sh/chart: {{ include "deploy.chart" . }}
{{ include "deploy.node.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "deploy.node.selectorLabels" -}}
app.kubernetes.io/name: {{ include "deploy.node.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "deploy.node.serviceAccountName" -}}
{{- if .Values.node.serviceAccount.create -}}
    {{ default (include "deploy.node.fullname" .) .Values.node.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.node.serviceAccount.name }}
{{- end -}}
{{- end -}}






{{- define "deploy.react.name" -}}
    {{- $name := default .Chart.Name .Values.react.nameOverride -}}
    {{- printf "%s-react" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "deploy.react.fullname" -}}
    {{- if .Values.react.fullnameOverride -}}
        {{- .Values.react.fullnameOverride | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
        {{- $name := default .Chart.Name .Values.react.nameOverride -}}
        {{- printf "%s-%s-react" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- end -}}

{{- define "deploy.react.labels" -}}
helm.sh/chart: {{ include "deploy.chart" . }}
{{ include "deploy.react.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "deploy.react.selectorLabels" -}}
app.kubernetes.io/name: {{ include "deploy.react.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "deploy.react.serviceAccountName" -}}
{{- if .Values.react.serviceAccount.create -}}
    {{ default (include "deploy.react.fullname" .) .Values.react.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.react.serviceAccount.name }}
{{- end -}}
{{- end -}}
