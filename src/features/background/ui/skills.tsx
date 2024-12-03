"use client";
import { Badge } from "@/components/ui/badge";

type Props = { skills: string[] };
export function Skills({ skills }: Props) {
  return (
    <article className="flex flex-wrap gap-2">
      {skills.map((skill) => (
        <Badge
          className="cursor-pointer"
          key={skill}
          onClick={() => console.log(skill)}
        >
          {skill}
        </Badge>
      ))}
    </article>
  );
}